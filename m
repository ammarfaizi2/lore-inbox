Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286934AbRL1R1I>; Fri, 28 Dec 2001 12:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284139AbRL1R07>; Fri, 28 Dec 2001 12:26:59 -0500
Received: from ms1.adiis.net ([207.177.36.3]:7345 "EHLO ms1.adiis.net")
	by vger.kernel.org with ESMTP id <S284138AbRL1R0m>;
	Fri, 28 Dec 2001 12:26:42 -0500
Subject: Re: VIA based motherboards
From: Ryan Butler <rbutler@adiis.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 28 Dec 2001 11:26:39 -0600
Message-Id: <1009560400.13453.3.camel@dialupoffice.adiis.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2001-12-27 at 20:57, Trever L. Adams wrote:
> Ok, I had read several reviews of the Soyo Dragon Plus saying it was
> great and stable with Linux (kt266a based board).
> 
> I have a Micron 256 Meg DDR DIMM in my system.  With my Permedia 2 video
> card and my hard drives (and every built in thing turned off and all
> other components not mentioned removed) the system crashes at boot if I
> let Linux use all 256 Meg.  If I say mem=240M it works fine (as far as I
> have seen).  If I say anything over 240M, either it hangs when trying to
> print out the partition table check on boot, or it hangs in the SCSI
> card driver for my Symbios 876 based card (if it is in... maybe if it is
> out, didn't check).
> 

I have a single 512 meg DDR DIMM and have not experienced the problem
you are.

> test, around 9 passes I believe, the tests passed with no problems.  My
> system hung around 8 hours later with all keyboard LED lights on, it
> rebooted and started running the test again.  The keyboard stayed hung
> until power was physically removed from the computer AND keyboard was
> unplugged and plugged back in.
> 

Just to relate another lockup mystery with the K7 Soyo Dragon Plus,
after install it would lockup within 3-20 minutes repeatedly under
2.4.16, 2.4.9, and 2.4.2.  I messed around in the bios until I mangaged
to get most of the cards on their own interrupts, still locked hard.

The only way I was able to get the system stable was to remove the 2
3c905 (one was a straight 905, one was a 905C-TXM) from the system.  I
replaced them with a 3c590 and its been stable ever since.

Ryan Butler
rbutler@adiis.net


