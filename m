Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292991AbSCMRYT>; Wed, 13 Mar 2002 12:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292986AbSCMRYJ>; Wed, 13 Mar 2002 12:24:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34820 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310858AbSCMRXy>; Wed, 13 Mar 2002 12:23:54 -0500
Subject: Re: linux-2.5.6 scsi DMA mapping and compilation fixes (not yet working)
To: adam@yggdrasil.com (Adam J. Richter)
Date: Wed, 13 Mar 2002 17:38:59 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, davej@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <200203131717.JAA09703@adam.yggdrasil.com> from "Adam J. Richter" at Mar 13, 2002 09:17:52 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lCiJ-0006xx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> NCR drivers in 2.4.18 and 2.5.6, but looking at the changes with
> "diff -w" shows very few other changes, just really ancilliary
> things like option parsing.

That sounds like its some half step

> 	I was a little surprised to see things like procedure
> declaration lines ending in "{", which I understand confuses vi

My driver doesn't have lines ending in { like that

> 	I believe the code in 2.5.6 is your new NCR driver,
> in spite of the formatting differences.

Sounds like a weird half change - best to pick up the 2.4.18 one otherwise
it'll be a nightmare to merge future fixes into both

