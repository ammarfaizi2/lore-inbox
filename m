Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVAMU6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVAMU6e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 15:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVAMUzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 15:55:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49092 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261438AbVAMUwC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 15:52:02 -0500
Date: Thu, 13 Jan 2005 15:22:31 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113172230.GA6162@logos.cnet>
References: <20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112174203.GA691@logos.cnet> <1105627541.4624.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105627541.4624.24.camel@localhost.localdomain>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 03:36:27PM +0000, Alan Cox wrote:
> On Mer, 2005-01-12 at 17:42, Marcelo Tosatti wrote:
> > The kernel security list must be higher in hierarchy than vendorsec.
> > 
> > Any information sent to vendorsec must be sent immediately for the kernel
> > security list and discussed there.
> 
> We cannot do this without the reporters permission. Often we get
> material that even the list isn't allowed to directly see only by
> contacting the relevant bodies directly as well. The list then just
> serves as a "foo should have told you about issue X" notification.

Well the reporters, and vendorsec, have to be aware that the 
"kernel security list" is the main discussion point of kernel security issues.

If the embargo period is reasonable for vendors to prepare their updates and 
do necessary QA, there should be no need for kernel issues to be coordinated 
(and embargoed) on vendorsec anymore. Does it make sense?
Of course vendorsec gets informed of what is happening at "kernel security list".

The main reason for reporters to require "permission" to spread the information
is because they want make a PR of their discovery, yes?

In that case they should be aware that submitting to vendorsec means submitting
to kernel security, and that means X days of embargo period.

> If you are setting up the list also make sure its entirely encrypted
> after the previous sniffing incident.

Definately, I asked Chris about it...
