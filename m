Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266936AbTBVQqz>; Sat, 22 Feb 2003 11:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267033AbTBVQqz>; Sat, 22 Feb 2003 11:46:55 -0500
Received: from web20509.mail.yahoo.com ([216.136.226.144]:2989 "HELO
	web20509.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266936AbTBVQqx>; Sat, 22 Feb 2003 11:46:53 -0500
Message-ID: <20030222165701.42995.qmail@web20509.mail.yahoo.com>
Date: Sat, 22 Feb 2003 08:57:01 -0800 (PST)
From: RF4 <slowtrainmojo@yahoo.com>
Subject: ide-scsi bug: 2.4.21-pre4
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-294354847-1045933021=:42902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-294354847-1045933021=:42902
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

> --- Original message follows.
> 
> Return-Path: <slowtrainmojo@yahoo.com>
> Message-ID: <20030222164904.76070.qmail@web20507.mail.yahoo.com>
> Received: from [66.234.210.48] by web20507.mail.yahoo.com via HTTP; Sat, 22
> Feb 2003 08:49:04 PST
> Date: Sat, 22 Feb 2003 08:49:04 -0800 (PST)
> From: RF4 <slowtrainmojo@yahoo.com>
> Subject: ide-scsi bug
> To: marcelo@freak.distro.conectiva
> MIME-Version: 1.0
> Content-Type: text/plain; charset=us-ascii
> 
> module ide-scsi causes kernel panic
> (at least when included _in_ kernel)
> ...i'm not using a debuggable kernel,
> so i don't have the register dumps and all that,
> but here is the relevant parts of my dmesg
> (from a stable kernel):
> .
> .
> hdd: CR-4802TE, ATAPI CD/DVD-ROM drive
> .
> .
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
>   Vendor: MITSUMI   Model: CR-4802TE         Rev: 2.0D
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
> sr0: scsi3-mmc drive: 8x/8x writer cd/rw xa/form2 cdda tray
> .
> .
> 
> ummmm.... being a software engineer, i know what a pain it can be
> to debug, so i'm trying to think of what else i can give you specifically... 
> i tried the -ac4 patch and it still did the same thing...  i don't use
> modules...  this is on a PII 233 (yeah ok i need to buy a new computer).
> 
> anyway, cheers!
> 
> - Ray Foulk

__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - forms, calculators, tips, more
http://taxes.yahoo.com/
--0-294354847-1045933021=:42902
Content-Type: application/octet-stream; name=".config.bz2"
Content-Transfer-Encoding: base64
Content-Description: .config.bz2
Content-Disposition: attachment; filename=".config.bz2"

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
Cd8DadSARHgnn2rDSvK5th0p/i7kinChIavHRmA=

--0-294354847-1045933021=:42902--
