Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314525AbSEYMdu>; Sat, 25 May 2002 08:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314548AbSEYMdt>; Sat, 25 May 2002 08:33:49 -0400
Received: from s217-115-138-173.colo.hosteurope.de ([217.115.138.173]:62983
	"HELO mail.cionix.de") by vger.kernel.org with SMTP
	id <S314525AbSEYMds>; Sat, 25 May 2002 08:33:48 -0400
Message-ID: <1022329607.3cef83072437b@mail.cionix.de>
Date: Sat, 25 May 2002 14:26:47 +0200
From: jan.lists@cionix.de
To: linux-kernel@vger.kernel.org
Subject: Very High Load on Disk Activity in 2.4.18 (and 2.4.18-pre8)
In-Reply-To: <20020525121737Z314546-22651+55555@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 212.7.141.220
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm experiencing a strange effect. As soons as there is some higher disk 
activity (untarring the linux kernel is enough, which really should be no 
problem) the system load gets really high (some times over 10) but the CPU
is 100% idle (reported by top).

Usually the system freezes for some minutes (but is still replying to pings)
and is after this period (when disk I/O is finished) fully usable again.

There are no error messages in all logfiles and nothing seems to be wrong
except of this _really_ annoying 3-10 minute freezes under high activity.

I definatly have no idea what to do. I'm very shure that my SCSI-wiring 
and the other hardware ist ok. There a no error messages or warnings in
"dmesg" or the normal system logs.I run various Hardwaretest, all are ok.

I read about similar problems in earlier Version of 2.4.x Kernels but these
are reported to be fixed. Are any Problems in the Mylex drivers or the
kernels VM known (and hopefully work arounds) that can cause this
behaviour?

thanks in advance and sorry for my bad englisch.

regards

jan schreiber

More info about the machine:

- Mylex Accleraid 352 (flashed to latest firmware)
- Intel Pentium III 1,2 GHz, 512 MB Ram, Intel i815 Chipset
- 10 36 GB SCSI drives connected (8 on Channel 0, 2 on channel 1), no other 
devices connected
- Build one RAID-5 Drive out of 9 disks, the 10 disk is spare
- three primary Partitons (512 MB swap, 2 GB system , rest data partiton 
(approx 270 Gb)
- Running SuSE 8.0 Pro
- Kernel 2.4.18 (from suse, built a new vanilla 2.4.18 and pre8 with same 
results)
- using reiserfs 3.6 on all Partitons (except swap of course)


Mit freundlichen Gruessen
cionix GmbH

Jan Schreiber
Geschäftsführer | chief executive officer

_____________________________________
cionix GmbH
Bredower Str. 45       D-14612 Falkensee

Tel: [+49] Ø3322.2336-10
Fax: [+49] Ø3322.2336-11

http://www.cionix.de       eMail: js@cionix.de
_____________________________________

