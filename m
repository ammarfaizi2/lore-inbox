Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVAMWOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVAMWOo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbVAMWOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:14:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47242 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261780AbVAMWHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 17:07:11 -0500
Date: Thu, 13 Jan 2005 17:06:52 -0500
From: Dave Jones <davej@redhat.com>
To: Marek Habersack <grendel@caudium.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113220652.GJ3555@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Marek Habersack <grendel@caudium.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
	akpm@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112174203.GA691@logos.cnet> <1105627541.4624.24.camel@localhost.localdomain> <20050113194246.GC24970@beowulf.thanes.org> <20050113115004.Z24171@build.pdx.osdl.net> <20050113202905.GD24970@beowulf.thanes.org> <1105645267.4644.112.camel@localhost.localdomain> <20050113210229.GG24970@beowulf.thanes.org> <20050113213002.GI3555@redhat.com> <20050113214814.GA9481@beowulf.thanes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113214814.GA9481@beowulf.thanes.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 10:48:14PM +0100, Marek Habersack wrote:
 
 > > If admins don't install updates in a timely manner, there's
 > > not a lot we can do about it.  For those that _do_ however,
 > > we can make their lives a lot more stress free.
 > Indeed, but what does have it to do with a closed disclosure list? 

For the N'th time, it gives vendors a chance to have packages
ready at the time of disclosure.

 > With open
 > disclosure list you provide a set of fixes right away, the admins take them
 > and apply. With closed list you do the same, but with a delay (which gives
 > an opportunity for a "race condition" with the bad guys, one could argue).
 > So, what's the advantage of the delayed disclosure?

Not having to panic and rush out releases on day of disclosure.
Not having users vulnerable whilst packages build/get QA/get pushed to mirrors.

Users of kernel.org kernels get to build and boot in under an hour.
Vendor kernels take a lot longer to build.

1- More architectures.
   (And trust me, there's nothing I'd like more than to be able
	to increase the speed of kernel builds on some of the architectures
	we support).
2- More generic, ie more modules to build.

In the case of public disclosure of issues that we weren't aware of,
it's a miracle that we get update kernels out on day of disclosure
in some cases. (In others, we don't, and the same applies to other vendors too)

		Dave

