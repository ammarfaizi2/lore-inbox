Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVAMRGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVAMRGJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVAMQma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 11:42:30 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:34020 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261231AbVAMQlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 11:41:18 -0500
Subject: Re: thoughts on kernel security issues
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: "Barry K. Nathan" <barryn@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <878y6xr9gr.fsf@deneb.enyo.de>
References: <20050112094807.K24171@build.pdx.osdl.net>
	 <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
	 <20050112185133.GA10687@kroah.com>
	 <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
	 <20050112161227.GF32024@logos.cnet>
	 <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
	 <20050112205350.GM24518@redhat.com>
	 <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>
	 <20050113032506.GB1212@redhat.com>
	 <20050113035331.GC9176@beowulf.thanes.org>
	 <20050113053807.GE4378@ip68-4-98-123.oc.oc.cox.net>
	 <878y6xr9gr.fsf@deneb.enyo.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105630353.4644.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 15:36:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-13 at 08:59, Florian Weimer wrote:
> This is the exception.  Usually, changelogs are cryptic, often
> deliberately so.  Do you still remember Alan's DMCA protest
> changelogs?

They were not cryptic, just following the law to the point it claimed
neccessary....

That aside right now because Linus doesn't give us heads up we vendor
spend our time scanning all Linus' diffs and playing spot the security
fix because we know the bad guys do the same, and they are rather good
at it. Its useful anyway - eg its how we found that base kernels have
broken AX.25, and several other patches got tagged for immediate revert
in the -ac tree (and of course reported back upstream to l/k) but its a
pain to have to do it this way.

Having a list that fed such notices on to vendor-sec with a date fixed
by them is a real possible improvement - thats how we work with many
other projects. I also don't see any reason that Linus or Andrew
wouldn't be able to become a CAN issuing authority for security
advisories.

Alan

