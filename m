Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293060AbSDCGkq>; Wed, 3 Apr 2002 01:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293035AbSDCGkj>; Wed, 3 Apr 2002 01:40:39 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:56639 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S293161AbSDCGkT> convert rfc822-to-8bit; Wed, 3 Apr 2002 01:40:19 -0500
From: "Dipl.-Inform. Guus Leeuw jr." <gleeuw@mlcon-gmbh.de>
To: "'Bill Davidsen'" <davidsen@tmr.com>,
        "'Linux-Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: AW: Ext2 vs. ext3 recovery after crash
Date: Wed, 3 Apr 2002 08:38:08 +0200
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAteULRAf1EkSKk2Jex/SYAMKAAAAQAAAAlGAl4xZl0ka+uYUq9EHmRwEAAAAA@mlcon-gmbh.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <Pine.LNX.3.96.1020402225256.9671A-100000@gatekeeper.tmr.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill,

Just for the sake of it, the C600 should be a Latitude :)

Anyways, I had a C600 before as well, first on SuSE then on Redhat
because
For RedHat it is easier to recompile new kernels etc, being the reason I
kicked of SuSE.
I installed 7RH.2 and downloaded 2.4.17 sources to run on it, since
newer is better :)
Never had any problems. (I hope you did not specify DELL Support in the
options, did you?)

Than I bought myself an Inspiron4100 which is now running 2.4.18. The
only flaky things I've seen
Is sound support on KDE, but that might have been related to aRts, and
the ide-scsi driver does not
Seem to work anymore since 2.4.17. Rest is all fine, even APM and the
stuff.
I usually have uptimes of 8 hours, during the week, and 2.5 days over
the weekend.

I compile newer kernels for my Inspiron always with DELL Laptop Support,
which I never do for my C600.
Both are currently happily running 2.4.18. Both kernels supports ext3
and all filesystems except /dev/cdrom
Are running ext3. X Environment is XFree4 with ATI Mobility Radeon M6
Drivers. Kernel doesn't do any
Framebuffering whatsoever, but supports the AGP Drivers for Radeon. X
Desktop is KDE2, or KDE3RC3 depending on what I want to do :)

Compiler: gcc 2.95.x

Just my $0.02,
Guus

-----Ursprüngliche Nachricht-----
Von: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] Im Auftrag von Bill Davidsen
Gesendet: Mittwoch, 3. April 2002 06:03
An: Linux-Kernel Mailing List
Betreff: Ext2 vs. ext3 recovery after crash


I have a laptop (Dell Inspiron C600) which, like most Dell laptops,
crashes every time I log out of X. On some occasions on reboot I get a
message about replaying the journal, while occasionally I get a full
ext2 style multi-pass 12 minute recovery. I don't see why the ext3 isn't
always used, I know it's going to crash, I always do a sync and wait ten
seconds for journal writes, etc, to take place.

I have tried all the usual, Redhat kernels, 2.4.17, 2.4.19, -aa, -ac,
disable io-apc, disable apic, disable all power management, boot noapic
(someone swore it wasn't enough to pull it out of the kernel ;-) all
producing about 20% chance of slow reboot.

Since I would have to spend my own money to replace this device with
something functional before 2003, is there something I'm missing about
why it does the slow cleanup? It was Redhat 7.1, updated fsutils and
modutils, pcmcia packed, etc, to latest of Mar 15 this year, in case
that matters. All kernels have ext3 compiled in, all work "most of the
time."

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

