Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263843AbTLJTdd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 14:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263902AbTLJTdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 14:33:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:10887 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263843AbTLJTda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 14:33:30 -0500
Date: Wed, 10 Dec 2003 20:30:55 +0100
From: Jens Axboe <axboe@suse.de>
To: Joe Thornber <thornber@sistina.com>, Paul Jakma <paul@clubi.ie>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Device-mapper submission for 2.4
Message-ID: <20031210193054.GA24512@suse.de>
References: <20031209134551.GG472@reti> <Pine.LNX.4.44.0312091206490.1289-100000@logos.cnet> <20031209143412.GI472@reti> <Pine.LNX.4.56.0312092106280.30298@fogarty.jakma.org> <20031209222624.GA6591@reti> <20031210084546.GG3988@suse.de> <Pine.LNX.4.56.0312101726340.1218@fogarty.jakma.org> <20031210174418.GF476@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031210174418.GF476@reti>
X-OS: Linux 2.4.23aa1-axboe i686
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10 2003, Joe Thornber wrote:
> On Wed, Dec 10, 2003 at 05:30:01PM +0000, Paul Jakma wrote:
> > On Wed, 10 Dec 2003, Jens Axboe wrote:
> > 
> > > Arguments akin to "But XFS got merged, surely we can to" don't hold
> > > up one bit. Should be obvious why.
> > 
> > Its not about a /new/ feature, its about an existing feature which is 
> > incompatible between 2.4 and 2.6.
> > 
> > I dont really care whether its done via forward or backware compat. 
> > (but why was LVM1 removed from 2.6?)
> 
> The LVM1 driver was removed because dm covered the same functionality
> + lots more, and is more flexible.  The LVM2 tools still understand
> the LVM1 metadata format, so there is no problem about not being able
> to read data in 2.6.  The main reason for submitting dm to 2.4 was

Great, so then there's zero reason to merge it in 2.4.

