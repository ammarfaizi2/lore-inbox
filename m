Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVCJVFC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVCJVFC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 16:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbVCJVFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 16:05:01 -0500
Received: from waste.org ([216.27.176.166]:8084 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261711AbVCJVCr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 16:02:47 -0500
Date: Thu, 10 Mar 2005 13:02:18 -0800
From: Matt Mackall <mpm@selenic.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andries Brouwer <aebr@win.tue.nl>, Alexander Nyberg <alexn@dsv.su.se>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: dm-crypt vs. cryptoloop reminder
Message-ID: <20050310210218.GB3163@waste.org>
References: <1110058524.13821.17.camel@boxen> <20050305224415.GA8837@pclin040.win.tue.nl> <20050309193212.GB632@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050309193212.GB632@openzaurus.ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 08:32:13PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > 2.6.3-mm1 'dm-crypt vs. cryptoloop' discussion was some time ago, it is
> > > time to bring this up again:
> > > http://kerneltrap.org/node/2433
> > 
> > Are you a troll?
> > 
> > This is not something to be quoted by anybody serious.
> > 
> > Andrew referred to "well-known weaknesses" in cryptoloop,
> > and when I inquired it turned out that what he referred to
> > were properties of cryptoloop and dm-crypt alike, so that
> > his remarks that started that discussion were misguided.
> > 
> > Of course people may prefer dm-crypt or cryptoloop or loop-aes,
> > just like people prefer ide-cd or ide-scsi.
> > 
> > I have not yet seen a valid reason to deprecate one of these three
> > very soon.
> 
> I'd say that "no-maintainer" + "maintained code can do the same" is enough, but...
> I thought that ide-scsi was deprecated, too?

You can attach a file to loopback and then run dm-crypt on top of
that, so I think it's completely duplicate functionality at this
point.

-- 
Mathematics is the supreme nostalgia of our time.
