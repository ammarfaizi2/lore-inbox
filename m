Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311917AbSCODKo>; Thu, 14 Mar 2002 22:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311920AbSCODKY>; Thu, 14 Mar 2002 22:10:24 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:45761 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S311917AbSCODKO>; Thu, 14 Mar 2002 22:10:14 -0500
Date: Thu, 14 Mar 2002 20:09:57 -0700
Message-Id: <200203150309.g2F39vA15319@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VGA blank causes hang with 2.4.18 
In-Reply-To: <8380.1016161366@kao2.melbourne.sgi.com>
In-Reply-To: <200203150252.g2F2qVM15051@vindaloo.ras.ucalgary.ca>
	<8380.1016161366@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:
> On Thu, 14 Mar 2002 19:52:31 -0700, 
> Richard Gooch <rgooch@ras.ucalgary.ca> wrote:
> >  Hi, all. Here's a perverse problem: when the screen blanks (text
> >console) with 2.4.18, the machine hangs. No ping response, no magic
> >SysReq response. I didn't have this problem with 2.4.7.
> >
> >The command I used to configure screen blanking was:
> >setterm -blank 10 -powerdown 0
> >
> >This is an Athalon 850 MHz on a Gigabyte GA-7ZM motherboard.
> 
> Any response with kdb + nmi watchdog + serial console?  Sounds like
> a lock problem, kdb + nmi watchdog normally lets you debug those.

This box isn't set up for serial console. It's a production box, and
it's running jobs again :-)

Besides, until kdb is integrated into the kernel, I'm not likely to
use it (yeah, I know, hell will have to freeze over first).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
