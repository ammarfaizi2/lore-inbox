Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313116AbSDIJDv>; Tue, 9 Apr 2002 05:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313828AbSDIJDu>; Tue, 9 Apr 2002 05:03:50 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:30983 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S313116AbSDIJDu>; Tue, 9 Apr 2002 05:03:50 -0400
Message-Id: <200204090901.g3991JX01875@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: [DEADLOCK] automount, kupdated: D state
Date: Tue, 9 Apr 2002 12:04:32 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <5.1.0.14.2.20020405155322.01ff3b40@pop.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 April 2002 12:59, Anton Altaparmakov wrote:
> >kernel: 2.5.7 + new NTFS driver
> >ps and ksymoopsed parts of Alt-Sysrq-T output are attached.
> >ksymoops warnings trimmed except automount.dump.ksymoops
> >(they were the same).
>
>  From looking at the information supplied, NTFS doesn't seem to be
> involved. The processes seem to be stuck trying to write dirty buffers as
> well as in nfs and pipefs - buffers could never get dirtied by the current
> NTFS as it is entirely read-only.

I don't think NTFS is related, I just wanted people to know what kernel I'm 
using.

> btw. You had sent a problem report about cyrillic names with NTFS and I
> suggested to try the new NTFS driver but you never got back to me whether
> that fixed it or not... How is the new driver behaving? Are you stil seing
> problems or is everything working fine now?

I tried four times to post a reply to lkml, never seen my own posts.
This is becoming a problem, need to debug email route to lkml :-)

I needed storage badly and had to delete problematic files before 
trying new NTFS driver, sorry. :-( Now I'm running 2.5.7 with new driver,
seems to work fine. Well done! I'll report anything unusual.

Are there any plans for RW support for NTFS?
--
vda
