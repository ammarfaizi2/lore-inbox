Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbRCZW37>; Mon, 26 Mar 2001 17:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129568AbRCZW3t>; Mon, 26 Mar 2001 17:29:49 -0500
Received: from ns0.petreley.net ([64.170.109.178]:10142 "EHLO petreley.com")
	by vger.kernel.org with ESMTP id <S129524AbRCZW3k>;
	Mon, 26 Mar 2001 17:29:40 -0500
Date: Mon, 26 Mar 2001 14:28:58 -0800
From: Nicholas Petreley <nicholas@petreley.com>
To: Kirill Kozmin <kozkir-8@student.luth.se>
Cc: Andre Hedrick <andre@linux-ide.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: VIA686b chipset and dma_intr errors, and 3c905B errors
Message-ID: <20010326142858.A664@petreley.com>
In-Reply-To: <Pine.LNX.4.10.10103161041040.14210-100000@master.linux-ide.org> <3AB93A75.D18A78EE@student.luth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <3AB93A75.D18A78EE@student.luth.se>; from kozkir-8@student.luth.se on Thu, Mar 22, 2001 at 12:34:13AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Ok, now its clear that I have a big troubles with hardware.
> I compiled kernel 2.2.18+IDE_patches with support for VIA chipset and still get
> errors of type:
> 
> kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> 
> before these kernel reports a long string of messages
> 

I got those errors on a brand new IBM ATA100 drive.  I
exchanged it for a new one which worked fine for a couple
of weeks, but now the new one is beginning to give me the
same errors.  I've noticed a rash of people reporting these
errors since 2.4.x.  Is it really that the new kernel is
simply better at reporting bad drives?  Or is there
something else going on with the kernel?  (Or are IBM
drives just crappy?)

Here's a portion of the messages I'm getting...

hda: dma_intr: status=0x51 { DriveReady SeekComplete Error}
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=48973752, sector=1854944
end_request: I/O error, dev 03:08 (hda), sector 1854944

asus a7v/kt133
IDE is Via 686b

By the way, my 3c905B went bahooties since about ac21 I
think.  I was under the impression that Alan backed out of
the suspected changes for ac23 but the problem remained.  I
replaced it with an eepro100, but I don't know if it's the
card or what.

-Nick


-- 
**********************************************************
Nicholas Petreley   Caldera Systems - LinuxWorld/InfoWorld
nicholas@petreley.com - http://www.petreley.com - Eph 6:12
**********************************************************
.
