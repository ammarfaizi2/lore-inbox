Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264678AbRFVCOO>; Thu, 21 Jun 2001 22:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264680AbRFVCOE>; Thu, 21 Jun 2001 22:14:04 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:16902 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S264678AbRFVCN7>;
	Thu, 21 Jun 2001 22:13:59 -0400
Date: Thu, 21 Jun 2001 22:15:51 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Nicolas Pitre <nico@cam.org>
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: Missing help entries in 2.4.6pre5
Message-ID: <20010621221551.A9839@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Nicolas Pitre <nico@cam.org>, CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010621154934.A6582@thyrsus.com> <Pine.LNX.4.33.0106211812560.30096-100000@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0106211812560.30096-100000@xanadu.home>; from nico@cam.org on Thu, Jun 21, 2001 at 06:22:22PM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Pitre <nico@cam.org>:
> > CONFIG_XSCALE_IQ80310
> 
> 1- This symbol is mine;
> 2- It is part of 2.4.6-pre5 only as a dependency argument, with no
>    point where a value is actually assigned to it;
> 3- It is likely to be different when the actual question for which the
>    user need an help text is merged into the mainline kernel.
> 
> So you can safely ignore it for now.

I've put it on my ignore list.
 
> Maybe it could be a good thing for your tool to ignore missing help text for
> symbols that don't get enabled interactively by the user?

It already does that for derivations (in CML1, define_*).  The real problem 
here is that my report generators aren't smart enough to tell when a CML1
symbol is referenced in a CML1 config but never set.  That problem could be
solved, but it's unusual that I don't think it's worth the effort.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The day will come when the mystical generation of Jesus by the Supreme
Being as his father, in the womb of a virgin, will be classed with the
fable of the generation of Minerva in the brain of Jupiter.
	-- Thomas Jefferson, 1823
