Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272067AbTGYN3v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 09:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272068AbTGYN3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 09:29:51 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:63441 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S272067AbTGYN3s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 09:29:48 -0400
Date: Fri, 25 Jul 2003 15:44:31 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: <reg@dwf.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21, 2.6.0-test1 dont see disk controller.
In-Reply-To: <200307250220.h6P2Ku33005334@orion.dwf.com>
Message-ID: <Pine.SOL.4.30.0307251541400.26920-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You should enable "Special FastTrak Feature" config option
for Promise controller.
--
Bartlomiej

On Thu, 24 Jul 2003 reg@dwf.com wrote:

> I have one disk (containing the root partition) on the disk controller
> on the motherboard, and a second disk on its own PCI (IDE) controller
>   [ Promise Tech Chp, ATA 133 ]
>
> Under 2.4.19 and 2.4.20 everything worked as soon as I plugged in the
> card to the motherboard.
>
> With either 2.4.21 or 2.6.0-test1, the OS doesnt seem to see the controller,
> (no error messages), and you get down to a point where you are trying to
> mount the disk partitions, and you get error messages saying /dev/hde does
> not exist.
>
> What changed?
> Do I need an additional config line of some sort (Ive looked but dont see
> anything?)
> More details if necessary.
> --
>                                         Reg.Clemens
>                                         reg@dwf.com

