Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281445AbRKMDCc>; Mon, 12 Nov 2001 22:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281449AbRKMDCN>; Mon, 12 Nov 2001 22:02:13 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:20105 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281445AbRKMDCA>; Mon, 12 Nov 2001 22:02:00 -0500
Date: Mon, 12 Nov 2001 19:57:35 -0700
Message-Id: <200111130257.fAD2vZt15653@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: John Levon <moz@compsoc.man.ac.uk>
Cc: linux-kernel@vger.kernel.org, kaos@ocs.com.au
Subject: Re: GPLONLY kernel symbols???
In-Reply-To: <20011017151534.B91069@compsoc.man.ac.uk>
In-Reply-To: <Pine.LNX.4.33.0110160927030.24895-100000@devel.office>
	<30375.1003285059@kao2.melbourne.sgi.com>
	<20011017151534.B91069@compsoc.man.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon writes:
> On Wed, Oct 17, 2001 at 12:17:39PM +1000, Keith Owens wrote:
> 
> > If a symbol has been exported with EXPORT_SYMBOL_GPL then it appears as
> > unresolved for modules that do not have a GPL compatible MODULE_LICENCE
> > string.  So when a module without a GPL compatible MODULE_LICENCE gets
> > an unresolved symbol, I print that message as a hint to the user.  I
> > thought the response was obvious, but looks like I need to expand the
> > hint text even further.
> 
> How is the name mangled in the _GPL case ? Can't this be detected explicitly ?
> 
> richard, since ac seems OK with it ...

OK, I've applied your patch. Let's hope lusers don't start editing out
the "tainted" string when emailing Oops reports.

BTW: I had to edit after applying your patch: it didn't conform to the
Style[tm].

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
