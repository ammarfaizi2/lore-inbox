Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129784AbRBPJrJ>; Fri, 16 Feb 2001 04:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129887AbRBPJq7>; Fri, 16 Feb 2001 04:46:59 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:1064 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129784AbRBPJqx>; Fri, 16 Feb 2001 04:46:53 -0500
Date: Fri, 16 Feb 2001 03:46:44 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 8139 full duplex?
In-Reply-To: <200102160858.JAA02472@cave.bitwizard.nl>
Message-ID: <Pine.LNX.3.96.1010216034551.6404E-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2001, Rogier Wolff wrote:
> I have a bunch of computers with 8139 cards. When I moved the cables
> over from my hub to my new switch all the "full duplex" lights came on
> immediately.
> 
> Would this mean that the driver/card already were in full-duplex? That
> would explain me seeing way too many collisions on that old hub (which
> obviously doesn't support full-duplex).
> 
> (Some machines run 2.2 kernels, others run 2.4 kernels some run the
> old driver, others run the 8139too driver). 

Some versions of the driver bork the LED register, which may lead to
false assumptions.

Grab 2.4.1-ac, which includes the latest 8139too, and see what 'dmesg'
say about its autonegotiation...

	Jeff




