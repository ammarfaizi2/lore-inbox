Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265272AbRFUWk6>; Thu, 21 Jun 2001 18:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265273AbRFUWks>; Thu, 21 Jun 2001 18:40:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64018 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265272AbRFUWkf>;
	Thu, 21 Jun 2001 18:40:35 -0400
Date: Thu, 21 Jun 2001 23:40:02 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Nicolas Pitre <nico@cam.org>
Cc: "Eric S. Raymond" <esr@thyrsus.com>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Missing help entries in 2.4.6pre5
Message-ID: <20010621234002.Z18978@flint.arm.linux.org.uk>
In-Reply-To: <20010621154934.A6582@thyrsus.com> <Pine.LNX.4.33.0106211812560.30096-100000@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0106211812560.30096-100000@xanadu.home>; from nico@cam.org on Thu, Jun 21, 2001 at 06:22:22PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2001 at 06:22:22PM -0400, Nicolas Pitre wrote:
> On Thu, 21 Jun 2001, Eric S. Raymond wrote:
> > The following configuration symbols in 2.4.6pre5 do not have
> > Congfgure.help entries,:
> [...]
> > CONFIG_XSCALE_IQ80310
> 
> 1- This symbol is mine;
> 2- It is part of 2.4.6-pre5 only as a dependency argument, with no
>    point where a value is actually assigned to it;
> 3- It is likely to be different when the actual question for which the
>    user need an help text is merged into the mainline kernel.
> 
> So you can safely ignore it for now.
> 
> Maybe it could be a good thing for your tool to ignore missing help text for
> symbols that don't get enabled interactively by the user?

Eric - would it be easier if I just define_bool CONFIG_XSCALE_IQ80310 n ?

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

