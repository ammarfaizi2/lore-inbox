Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271903AbRIDHuD>; Tue, 4 Sep 2001 03:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271902AbRIDHtx>; Tue, 4 Sep 2001 03:49:53 -0400
Received: from [195.66.192.167] ([195.66.192.167]:5892 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S271919AbRIDHti>; Tue, 4 Sep 2001 03:49:38 -0400
Date: Tue, 4 Sep 2001 10:48:35 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <1067845821.20010904104835@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Re: nfs client serious problems under 2.2.20pre8/9
In-Reply-To: <20010903191849.D14519@plato.local.lan>
In-Reply-To: <20010903191849.D14519@plato.local.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tuesday, September 04, 2001, 6:18:49 AM, Ethan Benson <erbenson@alaska.net> wrote:
EB> I have encountered a serious problem with nfs under 2.2.20pre8 and
EB> pre9.
EB> after some ammount of time (2 weeks under pre8, only a few hours under
EB> pre9) most/all processes accessing an nfs filesystem go into
EB> unkillable disk sleep, and the kernel starts spewing:
EB>
EB> kernel: nfs: task 22509 can't get a request slot
EB>
EB> over and over again endlessly.  since processes using the filesystem
EB> are unkillable i am unable to even forcabily umount the problematic
EB> filesystem, seemingly the only way restore order is shutdown -r now :(

Looks like another argument against hard NFS mounts to me.
Does anybody knows why NFS hard mounts exist?
Is there any case when intr mounts is worse than hard ones?
-- 
Best regards,
VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua
http://port.imtp.ilyichevsk.odessa.ua/vda/


