Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261813AbREPH2d>; Wed, 16 May 2001 03:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261814AbREPH2Y>; Wed, 16 May 2001 03:28:24 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:62471 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261813AbREPH2O>; Wed, 16 May 2001 03:28:14 -0400
From: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
Message-Id: <200105160710.JAA01305@kufel.dom>
Subject: Re: LANANA: To Pending Device Number Registrants
To: kufel!hickam.af.mil!Sam.Bingner@green.mif.pg.gda.pl (Bingner Sam J.
	Contractor RSIS)
Date: Wed, 16 May 2001 09:10:44 +0200 (CEST)
Cc: kufel!ras.ucalgary.ca!rgooch@green.mif.pg.gda.pl ('Richard Gooch'),
        kufel!lxorguk.ukuu.org.uk!alan@green.mif.pg.gda.pl (Alan Cox),
        kufel!vger.kernel.org!linux-kernel@green.mif.pg.gda.pl
In-Reply-To: <4CDA8A6D03EFD411A1D300D0B7E83E8F697321@FSKNMD07.hickam.af.mil> from "Bingner Sam J. Contractor RSIS" at maj 15, 2001 11:49:40 
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> OK, just correct me if I get this wrong, but this code is taking the LAST 2
> characters of the device name and verifying that it is "cd".  Which would
> mean that the standard states that "/dev/ginsucd" would be a CD-ROM drive?
> 
> That is why I feel a "name" of a device handle shouldnt set how a driver
> operates in this fashion... if you make a small error in your compare, you
> might try to eject a Ginsu Cabbage Dicer instead of a cdrom drive... OOPS!
> 
> 	Sam Bingner
> 
> Alan Cox writes:
> > > 	len = readlink ("/proc/self/3", buffer, buflen);
> > > 	if (strcmp (buffer + len - 2, "cd") != 0) {
> > > 		fprintf (stderr, "Not a CD-ROM! Bugger off.\n");
> > > 		exit (1);
> > 
> > And on my box cd is the cabbage dicer whoops
> 
> Actually, no, because it's guaranteed that a trailing "/cd" is a
> CD-ROM. That's the standard.

Sure, you no longer support /dev/sdcd (eighty-second SCSI disk)...
;)

Andrzej
