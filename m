Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317017AbSIEH2x>; Thu, 5 Sep 2002 03:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317215AbSIEH2x>; Thu, 5 Sep 2002 03:28:53 -0400
Received: from relay.muni.cz ([147.251.4.35]:18377 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S317017AbSIEH2w>;
	Thu, 5 Sep 2002 03:28:52 -0400
Date: Thu, 5 Sep 2002 09:33:19 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Andrew D Kirch <trelane@trelane.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE write speed (Promise versus AMD)
Message-ID: <20020905093319.C3985@fi.muni.cz>
References: <20020904195729.A3985@fi.muni.cz> <001501c2546e$7e303720$6400a8c0@athlon2000>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <001501c2546e$7e303720$6400a8c0@athlon2000>; from trelane@trelane.net on Wed, Sep 04, 2002 at 06:55:05PM -0500
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew D Kirch wrote:
: excuse the mailer, but I've been having similar issues with my promise
: controller... interesting huh?  give me a little more info on the board and
: make sure to target a reply to trelane@trelane.net, I'll keep you posted on
: anything I find to fix it... right now my speed difference isn't THAT
: dramatic... Going to a beta mandrake install from 8.2 I've lost 40% of my
: software raid-0 performance (from a hdparm of 80MB/s to 56MB/s. :(
: 
: I'm going to play with jumpers later, so I'll let you know what I find.

	Mainboard is MSI K7D-Master (AMD 760 MPX chipset),
the Promise controller is PDC 20269 with the following lspci
output:

02:04.0 Unknown mass storage controller: Promise Technology, Inc. 20269 (rev 02) (prog-if 85)
	Subsystem: Promise Technology, Inc.: Unknown device 4d68
	Flags: bus master, 66Mhz, slow devsel, latency 32, IRQ 16
	I/O ports at 9000 [size=8]
	I/O ports at 9400 [size=4]
	I/O ports at 9800 [size=8]
	I/O ports at 9c00 [size=4]
	I/O ports at a000 [size=16]
	Memory at f8000000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=16K]
	Capabilities: [60] Power Management version 1

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
       Pruning my incoming mailbox after being 10 days off-line,
       sorry for the delayed reply.
