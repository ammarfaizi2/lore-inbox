Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbTJWEX5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 00:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbTJWEX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 00:23:57 -0400
Received: from d216-232-206-119.bchsia.telus.net ([216.232.206.119]:2567 "EHLO
	cyclops.implode.net") by vger.kernel.org with ESMTP id S261649AbTJWEXz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 00:23:55 -0400
Date: Wed, 22 Oct 2003 21:23:49 -0700
From: John Wong <kernel@implode.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: via-rhine on 2.4.23-pre6 Too much work at interrupt, status=0x00001000. (fwd)
Message-ID: <20031023042349.GA6861@gambit.implode.net>
References: <Pine.LNX.4.44.0310171852330.12627-100000@logos.cnet> <3F90687E.8030601@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F90687E.8030601@pobox.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could the problem detailed in the thread:

http://marc.theaimsgroup.com/?l=linux-kernel&m=106687979128274&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=106688008628516&w=2

with reference to 8390-based drivers affect the via-rhine driver?

John

On Fri, Oct 17, 2003 at 06:09:02PM -0400, Jeff Garzik wrote:
> >Date: Thu, 16 Oct 2003 12:27:17 -0700
> >From: John Wong <kernel@implode.net>
> >To: linux-kernel@vger.kernel.org
> >Subject: via-rhine on 2.4.23-pre6 Too much work at interrupt,
> >     status=0x00001000.
> >
> >The system used to run 2.4.22 and did not have this too much work
> >problem.  There were some other hardware changes.  The system used to be
> >a Pentium 100 on a Triton 430FX chipset Intel Advanced/EV board.  Now it 
> >is a K6 2 - 500 on a Via Apollo MVP3 chipset on FIC VA-503+ board.
> >The NIC stayed the same.  The kernel was recompiled and ACPI was
> >enabled.
> >
> >I noticed in 2.4.23-pre2 -> pre3
> >	 [netdrvr] sync with 2.5: epic100, fealnx, via-rhine, winbond-840
> 
> 
> This cset contains no functional via-rhine changes...  First thing to do 
> would be try to 2.4.23-pre2.  But my main suspect would be ACPI.
> 
> 	Jeff
> 
> 
> 
