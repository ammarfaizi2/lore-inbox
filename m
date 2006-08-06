Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWHFVff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWHFVff (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 17:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWHFVff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 17:35:35 -0400
Received: from host-84-9-217-225.bulldogdsl.com ([84.9.217.225]:9346 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S1750717AbWHFVff
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 17:35:35 -0400
Date: Sun, 6 Aug 2006 22:35:24 +0100
From: Ben Dooks <ben@fluff.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Fix base address configuration in wbsd
Message-ID: <20060806213524.GC8907@home.fluff.org>
References: <20060806202223.13663.66134.stgit@poseidon.drzeus.cx> <20060806204842.GE16816@flint.arm.linux.org.uk> <44D657BF.6070004@drzeus.cx> <20060806210509.GF16816@flint.arm.linux.org.uk> <44D65F4D.3060907@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D65F4D.3060907@drzeus.cx>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2006 at 11:29:49PM +0200, Pierre Ossman wrote:
> Russell King wrote:
> > Is that a safe assumption to make?  Is this only ever going to appear/be
> > used on x86?
> >
> >   
> 
> It's designed for ISA, so I think so. In the event that a version of
> this model appears that has a larger I/O base, then the configure
> registers will have been reordered (to make room for any extra address
> bytes), so the driver will not work out-of-box anyway.

ISA is very easy to glue to the simple IO busses on many
systems such as ARM.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
