Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270969AbTHBAsu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 20:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270976AbTHBAst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 20:48:49 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:30093
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S270969AbTHBAsl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 20:48:41 -0400
Date: Fri, 1 Aug 2003 21:03:52 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Greg KH <greg@kroah.com>, Grant Miner <mine0057@mrs.umn.edu>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: Zio! compactflash doesn't work
Message-ID: <20030801210352.B21542@animx.eu.org>
References: <3F26F009.4090608@mrs.umn.edu> <20030730231753.GB5491@kroah.com> <20030731011450.GA2772@win.tue.nl> <20030731041103.GA7668@kroah.com> <20030731005213.B7207@one-eyed-alien.net> <20030731065206.B15944@animx.eu.org> <20030801131145.GA3280@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20030801131145.GA3280@win.tue.nl>; from Andries Brouwer on Fri, Aug 01, 2003 at 03:11:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > What about this one:
> > Bus 001 Device 002: ID 0781:0005 SanDisk Corp. SDDR-05b (CF II) ImageMate
> > CompactFlash Reader
> 
> That is reported to work with the unusual dev patch
> 
> +/* glc: Greg Corcoran <gregc at spidex.com>  -- tested with SDDR-05b */
> +UNUSUAL_DEV(  0x0781, 0x0005, 0x0005, 0x0005,
> +               "Sandisk",
> +               "ImageMate SDDR-05b",
> +               US_SC_SCSI, US_PR_ZIOCF, init_ziocf,
> +               US_FL_START_STOP | US_FL_SINGLE_LUN),
> +
> 
> together with the Zio! driver at sourceforge, maybe
> 
>   http://usbat2.sourceforge.net/index.html
> 
> if I recall correctly.

I checked the link.  Doesn't look like the drive is ready for 2.6 which is
what I planned on using this with.  The chip on the device definately says
"usbat-2".  Unfortuantely, I'm not well versed in kernel hacking so I'll
have to wait til they port it.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
