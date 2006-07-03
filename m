Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWGCEBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWGCEBh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 00:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWGCEBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 00:01:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48012 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751177AbWGCEBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 00:01:36 -0400
Date: Sun, 2 Jul 2006 21:00:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@hansmi.ch, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org, khali@linux-fr.org,
       linux-kernel@killerfox.forkbomb.ch, johannes@sipsolutions.net,
       stelian@popies.net, chainsaw@gentoo.org
Subject: Re: [RFC] Apple Motion Sensor driver
Message-Id: <20060702210034.8abeb4d5.akpm@osdl.org>
In-Reply-To: <1151898448.19419.32.camel@localhost.localdomain>
References: <20060702222649.GA13411@hansmi.ch>
	<20060702201415.791c6eb2.akpm@osdl.org>
	<1151898448.19419.32.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jul 2006 13:47:28 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Sun, 2006-07-02 at 20:14 -0700, Andrew Morton wrote:
> > On Mon, 3 Jul 2006 00:26:49 +0200
> > Michael Hanselmann <linux-kernel@hansmi.ch> wrote:
> > 
> > > Below you find the latest revision of my AMS driver.
> > 
> > I was about to merge the below, then this comes along.  Now what?
> 
> Michael's driver is a new version that adds support for non-i2c (PMU
> based) chips found on new machines. It would be nice to have it, though
> it definitely needs a bit of review from Stelian, the original author.
> 
> What I would suggest at this point is to merge Stelian's original
> driver, as you were about todo, then have Michael produce a patch
> against it to be reviewed that could then be merged later on. I'm fine
> having that "later on" still be in the 2.6.18 timeframe since we aren't
> talking about anything critical here, just a fairly minor driver update
> that is nice to have, but we can decide that later based on the reviews
> of Michael's changes).

Yes, but it wouldn't be a "patch against it" - Michael's patch adds
multiple files with different names.  So it would be a revert-and-redo.

