Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266867AbUHDFGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266867AbUHDFGn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 01:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266787AbUHDFGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 01:06:43 -0400
Received: from mail.tpgi.com.au ([203.12.160.113]:51384 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S266867AbUHDFGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 01:06:38 -0400
Subject: Re: Solving suspend-level confusion
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>, Oliver Neukum <oliver@neukum.org>,
       Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <1091595811.5226.105.camel@gaston>
References: <20040730164413.GB4672@elf.ucw.cz>
	 <200408020938.17593.david-b@pacbell.net> <1091493486.7396.92.camel@gaston>
	 <200408031928.08475.david-b@pacbell.net>
	 <1091586381.3189.14.camel@laptop.cunninghams>
	 <1091587985.5226.74.camel@gaston>
	 <1091587929.3303.38.camel@laptop.cunninghams>
	 <1091592870.5226.80.camel@gaston>
	 <1091593555.3191.48.camel@laptop.cunninghams>
	 <1091595125.5227.96.camel@gaston>
	 <1091595258.3303.74.camel@laptop.cunninghams>
	 <1091595811.5226.105.camel@gaston>
Content-Type: text/plain
Message-Id: <1091595933.3303.82.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 04 Aug 2004 15:05:33 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-08-04 at 15:03, Benjamin Herrenschmidt wrote:
> On Wed, 2004-08-04 at 14:54, Nigel Cunningham wrote:
> > On Wed, 2004-08-04 at 14:52, Benjamin Herrenschmidt wrote:
> > > > Hmm. That's what I was doing and do do for the remainder of the devices.
> > > > Oh well. I'll give it a try again. What would 3 do? (There was a stage
> > > > when all three implementations used 3; I've just played sheep in
> > > > changing to 4).
> > > 
> > > 3 would be S3 -> suspend to RAM. We may still want to fix drivers to
> > > pass 4 as a PCI state though ;)
> > 
> > Okay. Wasn't sure whether it was D3 or S3 or something-else-3! I take it
> > the ide driver does the same thing for S3 and S4?
> 
> That's where the whole confusion is indeed... and why we need to make
> that clear. The IDE driver will sleep the disk for 3 and keep it spinning
> for 4

Okee doke. Maybe I did the partial tree code before the switch from 3 to
4.

Nigel

