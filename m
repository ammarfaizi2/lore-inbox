Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVAMUKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVAMUKw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 15:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVAMUHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 15:07:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:65204 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261519AbVAMUD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 15:03:29 -0500
Date: Thu, 13 Jan 2005 15:03:08 -0500
From: Dave Jones <davej@redhat.com>
To: Marek Habersack <grendel@caudium.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113200308.GC3555@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Marek Habersack <grendel@caudium.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
	Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112174203.GA691@logos.cnet> <1105627541.4624.24.camel@localhost.localdomain> <20050113194246.GC24970@beowulf.thanes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113194246.GC24970@beowulf.thanes.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 08:42:46PM +0100, Marek Habersack wrote:
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

Security researchers are an odd bunch. They're very attached to their
bugs in the sense they want to be the ones who get the glory for
having reported it.

As soon as bugs start getting forwarded around between lists, the
potential for leaks increases greatly. The recent fiasco surrounding
one of the isec.pl holes was believed to have been caused due to
someone 'sniffing upstream' for example.

When issues get leaked, the incentive for a researcher to use the
same process again goes away, which hurts us.  Basically, trying
to keep them happy is in our best interests.

		Dave

