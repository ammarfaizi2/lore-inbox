Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268934AbRG0TWi>; Fri, 27 Jul 2001 15:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268932AbRG0TWZ>; Fri, 27 Jul 2001 15:22:25 -0400
Received: from tomts13.bellnexxia.net ([209.226.175.34]:33022 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S268935AbRG0TV7>; Fri, 27 Jul 2001 15:21:59 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Hard disk problem:
In-Reply-To: <E15Q4Pg-0005MV-00@the-village.bc.nu> <3B61872C.6B1485B6@coppice.org>
From: Bill Pringlemeir <bpringle@sympatico.ca>
Date: 27 Jul 2001 15:18:12 -0400
In-Reply-To: Steve Underwood's message of "Fri, 27 Jul 2001 23:22:20 +0800"
Message-ID: <m2g0bi6v0r.fsf@sympatico.ca>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

>>>>> "Steve" == Steve Underwood <steveu@coppice.org> writes:

 Steve> But he is right. Practically all the "Made in Hungary" ones
 Steve> develop bad sectors after a few months. The "Made in
 Steve> Phillipinnes" ones do not.  Strangely, I am Hong Kong and
 Steve> almost all the GXP75s we got here were made in Hungary - go
 Steve> figure! They were so bad the dealers finally wouldn't stock
 Steve> them. If your experience has been different, think yourself
 Steve> lucky.

I have an IBM drive made in Hungary.  It get `fiery hot'!  I kept
moving it until I had it in a place with good thermal contact to the
case.  Then these drive errors went away.  At first I had a Linux
install on that drive.  Later it crashed, I fixed it, deleted the OS
on my HDA that I was no longer using and moved Linux there.  Now I
only keep MP3s, tmp, and swap (a 2nd one) on the IBM drive.

Sometimes when I close the case, I still get errors.  So it may be a
case of overheating.  You could try to change the position of the drive
to see if it fixes things.  Mine was made in Hungary.  And in case (ha ha)
I am talking crap,

[bpringle@localhost bpringle]$ dmesg | grep ^hdd:
hdd: IBM-DTTA-351010, ATA DISK drive
hdd: 19807200 sectors (10141 MB) w/466KiB Cache, CHS=19650/16/63, UDMA(33)

 Model=IBM-DTTA-351010, FwRev=T56OA73A, SerialNo=WF0WFFD7387
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=34
 BuffType=3(DualPortCache), BuffSize=466kB, MaxMultSect=16, MultSect=off
 DblWordIO=no, maxPIO=2(fast), DMA=yes, maxDMA=2(fast)
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=19807200
 WARNING 3293136 ORPHANED SECTORS :: KERNEL REPORTING ERROR
 tDMA={min:120,rec:120}, DMA modes: sword0 sword1 sword2 mword0 mword1 mword2
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, PIO modes: mode3 mode4
 UDMA modes: mode0 mode1 *mode2
 Drive Supports : ATA/ATAPI-4 T13 1153D revision 17 : ATA-1 ATA-2 ATA-3 ATA-4

fwiw,
Bill Pringlemeir.











