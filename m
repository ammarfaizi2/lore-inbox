Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263702AbVBCR1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbVBCR1M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 12:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbVBCR1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 12:27:11 -0500
Received: from THUNK.ORG ([69.25.196.29]:16315 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S263672AbVBCR04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 12:26:56 -0500
Date: Thu, 3 Feb 2005 12:26:47 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Zan Lynx <zlynx@acm.org>, Greg KH <greg@kroah.com>,
       Pavel Roskin <proski@gnu.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Please open sysfs symbols to proprietary modules
Message-ID: <20050203172647.GA7883@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Zan Lynx <zlynx@acm.org>,
	Greg KH <greg@kroah.com>, Pavel Roskin <proski@gnu.org>,
	Patrick Mochel <mochel@digitalimplant.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain> <Pine.LNX.4.50.0502021520200.1538-100000@monsoon.he.net> <20050202232909.GA14607@kroah.com> <Pine.LNX.4.62.0502021851050.19621@localhost.localdomain> <20050203003010.GA15481@kroah.com> <1107406442.23059.16.camel@localhost> <1107431398.14847.139.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107431398.14847.139.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 03:12:59PM +0000, Alan Cox wrote:
> On Iau, 2005-02-03 at 04:54, Zan Lynx wrote:
> > So, what's the magic amount of redirection and abstraction that cleanses
> > the GPLness, hmm?  Who gets to wave the magic wand to say what
> > interfaces are GPL-to-non-GPL and which aren't?
> 
> The "derivative work" distinction in law, which can be quite complex
> because it involves issues like intent. Other than the intentional clear
> statement that the syscall interface is considered a barrier by the
> authors there is no other statement.

When a copy actually takes place is another matter of law, and whether
an MacOS init which links in and patches MacOS to provide various
enhancements to MacOS, would therefore make Init a derived work of
MacOS is also a matter of law, and may very well vary based on your
the legal jourisdiction that you might happen to be in.  So it's
probably not worth discussing it (or the analogous situation involving
proprietary code dlopen'ing GPL'ed code, or proprietary modules which
use symbols that get linked into a GPL'ed kernel) on the Linux Kernel
mailing list.  To people who want to write proprietary modules and use
GPL'ed symbol exports --- take it up with your lawyer, and maybe
someday we'll have a few test cases and a decision one way or another
so that armchair lawyers don't have to keep discussing it.

It probably is worth saying that the non-legal concerns:

	* lack of cooperation from developers
	* the need to keep up with changing interfaces
	* the fact that the driver can't be included in the mainline kernel
	* refusal by distributions to carry the driver

are probably the more important things for companies that want to use
a proprietary driver model to consider.

						- Ted
