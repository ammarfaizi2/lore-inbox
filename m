Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271824AbTHDPrN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 11:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271827AbTHDPrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 11:47:13 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:41923
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S271824AbTHDPrJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 11:47:09 -0400
Date: Mon, 4 Aug 2003 11:47:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: David McBride <dwm99@doc.ic.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Status of ICH5-R SATA RAID support?
Message-ID: <20030804154708.GA26775@gtf.org>
References: <Pine.LNX.4.50.0308041446580.17591-100000@texel27.doc.ic.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0308041446580.17591-100000@texel27.doc.ic.ac.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 03:19:59PM +0100, David McBride wrote:
> Howdy,
> 
> Intel's ICH5-R chipset, as found on their D875PBZ motherboard, supports
> RAID-striping of SATA disks.
> 
> I've scoured the list archives and can't find any mention, for or
> against, for support of this feature -- Jeff Garzik's libata patchkit,
> although significant, doesn't appear to provide striping support.
> 
> Am I correct in thinking that there isn't any working striping support
> at the moment -- and if so, is anyone working on an implementation?
> If not, it might be fun to try and write support for it myself..


It's entirely software RAID, and as much, doesn't offer anything over
existing Linux software RAID ("md" driver).

I'm sure someone will eventually support it, but since Linux software
RAID works just fine, right now, in production, there is little
motivation to create yet another vendor-proprietary software RAID.

	Jeff




