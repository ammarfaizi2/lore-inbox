Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751721AbWHSLeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbWHSLeK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 07:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbWHSLeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 07:34:09 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:59016 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751721AbWHSLeI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 07:34:08 -0400
Date: Sat, 19 Aug 2006 13:30:52 +0200
To: David Schwartz <davids@webmaster.com>
Cc: alan@lxorguk.ukuu.org.uk,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: GPL Violation?
Message-ID: <20060819113052.GC3190@aitel.hist.no>
References: <1155919950.30279.8.camel@localhost.localdomain> <MDEHLPKNGKAHNMBLJOLKEEBCNOAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKEEBCNOAB.davids@webmaster.com>
User-Agent: Mutt/1.5.12-2006-07-14
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 03:42:10PM -0700, David Schwartz wrote:
> 
> > Ar Gwe, 2006-08-18 am 02:51 -0700, ysgrifennodd David Schwartz:
> 
> 	Re the DMCA issues with printers, courts seem to be holding that the rights
> management system has to enforce an actual right. Since a printer
> manufacturer has no right to limit you to cartridges he makes, the DMCA does
> not apply. (This would be very good if more courts would hold it more
> consistenly on other issues as well. Sadly, that may not be happening.)
> 
> > EXPORT_SYMBOL_GPL is clearly a rights management systems. Thats one of
> > its little charms.
> 
> 	No, it is not. If it was, it would violate the GPL. The GPL prohibits any
> restrictions not contained in the GPL, and the GPL doesn't say anything
> about EXPORT_SYMBOL_GPL. To the contrary, the GPL prohibits restrictions on
> use. So EXPORT_SYMBOL_GPL violates the GPL if you are not free to circumvent
> or remove it.
> 
> 	We had this same discussion a few years ago, and my recollection was that
> you agreed that EXPORT_SYMBOL_GPL could not be a license enforcement scheme.
> Which term of the GPL do you think it enforces exactly?
> 
> 	Whose rights does it enforce? (Considering that nobody has the right to
> prevent me from using the Linux kernel with an undistributed derivative work
> that is not covered by the GPL.)

Unlike other rights management systems you are allowed to circumvent or
remove the EXPORT_SYMBOL_GPL mechanism.  The GPL lets you.
It is still a rights management system, even if it isn't
forced upon the users.

Now, if someone actually distributes a closed-source module that
circumvents EXPORT_SYMBOL_GPL, or relies on an accompagnying
open source patch that removes the mechanism, this happens:

1. By doing this, they clearly showed that their module is outside the
   gray area of "allowed binary-only modules". They definitively
   made a "derived work" and distributed it.

2. Anybody who received this module may now invoke the GPL
   (and the force of law, if necessary) to extract the 
   module source code from the maker.  And then this source
   can be freely redistributed to all interested.

The vendor will be powerless to stop this, no amount of "third
party" patents / trade secrets / intellectual property
inside that module source can prevent its opening. The
module vendor broke all of that the moment they distributed
this nasty module, and set themselves up for this.  The vendor
is then the one who have to pay these third parties for 
opening their source.  They must bear the cost of
free licences for all on any third-party copyright.
Any _patented_ stuff may still be covered
of course, making the source less useable.  But the "trade secrets"
broke at the point of distributing a module with the GPL workaround.

So the rights management system works really well - it provides an
enforceable "the price for using these symbols is your code".


Sure, they can patch out the mechanism, but doing so will force them
to hand over the code, and then the module will be trivially rewritten
in a more appropriate way.  I.e. now that it is open, it can
use the GPL symbols without any workaround.

The mechanism itself is not protected by laws like the DMCA, because
its removal is explicitly allowed.  The great thing is, protection
of the _content_ is not lost when this happens.  

The same applies to everything else - before the DMCA, you could
legally break any copy protection scheme.  The content was still
protected by law.  In our case, enforcing it is easier though.

Helge Hafting
