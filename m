Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVAMTyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVAMTyo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 14:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVAMTvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:51:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:55732 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261460AbVAMTuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:50:05 -0500
Date: Thu, 13 Jan 2005 11:50:04 -0800
From: Chris Wright <chrisw@osdl.org>
To: Marek Habersack <grendel@caudium.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113115004.Z24171@build.pdx.osdl.net>
References: <20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112174203.GA691@logos.cnet> <1105627541.4624.24.camel@localhost.localdomain> <20050113194246.GC24970@beowulf.thanes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050113194246.GC24970@beowulf.thanes.org>; from grendel@caudium.net on Thu, Jan 13, 2005 at 08:42:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Marek Habersack (grendel@caudium.net) wrote:
> On Thu, Jan 13, 2005 at 03:36:27PM +0000, Alan Cox scribbled:
> > On Mer, 2005-01-12 at 17:42, Marcelo Tosatti wrote:
> > > The kernel security list must be higher in hierarchy than vendorsec.
> > > 
> > > Any information sent to vendorsec must be sent immediately for the kernel
> > > security list and discussed there.
> > 
> > We cannot do this without the reporters permission. Often we get
> I think I don't understand that. A reporter doesn't "own" the bug - not the
> copyright, not the code, so how come they can own the fix/report?

It's not about ownership.  It's about disclosure and common sense.
If someone reports something to you in private, and you disclose it
publically (or even privately to someone else) without first discussing
that with them, you'll lose their confidence.  Consequently they won't
be so kind to give you forewarning next time.

> > material that even the list isn't allowed to directly see only by
> > contacting the relevant bodies directly as well. The list then just
> > serves as a "foo should have told you about issue X" notification.
> This sounds crazy. I understand that this may happen with proprietary
> software, or software that is made/supported by a company but otherwise opensource
> (like OpenOffice, for instance), but the kernel?

Licensing is irrelevant.  Like it or not, the person who is discovering
the bugs has some say in how you deal with the information.  It's in our
best interest to work nicely with these folks, not marginalize them.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
