Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135780AbREFQpF>; Sun, 6 May 2001 12:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135782AbREFQoz>; Sun, 6 May 2001 12:44:55 -0400
Received: from cs140085.pp.htv.fi ([213.243.140.85]:56752 "EHLO
	porkkala.cs140085.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S135780AbREFQor>; Sun, 6 May 2001 12:44:47 -0400
Message-ID: <3AF57F63.9900089E@pp.htv.fi>
Date: Sun, 06 May 2001 19:44:19 +0300
From: Jussi Laako <jlaako@pp.htv.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Seth Goldberg <bergsoft@home.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Athlon possible fixes
In-Reply-To: <200105051626.SAA16651@cave.bitwizard.nl> <3AF4824F.8964E53B@home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seth Goldberg wrote:
> 
> and rebooted, the system stayed up a lot longer, but it still crashed (I
> was in Xwindows and the crash was partially written to the log file)
> after around 3 minutes of work in X.

Hmm, I'm wondering if this could be same bug that I'm seeing with ASUS
A7V133 & Duron/800 when using IDE autotuning (PDC20265).

Still haven't got any replies suggesting any reason for lockups I'm seeing
(no oopses). Or is the Promise driver just buggy, because system is solid
with noautotune. RAID5 (md) on that server is just little bit sluggish with
~1.7 MB/s transfer rate... I should have stayed with SCSI disks...

Can't use the VIA controller either, because there are four HDDs and one CD
and the system can't boot from CD connected to Promise controller (I
tested).

Is there somewhere some up-to-date list of "don't buy that hardware"?

 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
