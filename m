Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262640AbUCOS2n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 13:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbUCOS2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 13:28:43 -0500
Received: from ns.suse.de ([195.135.220.2]:19943 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262640AbUCOS2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 13:28:39 -0500
Subject: Re: aio tiobench
From: Chris Mason <mason@suse.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040315162954.GF655@holomorphy.com>
References: <20040315080520.GC655@holomorphy.com>
	 <1079357322.4186.377.camel@watt.suse.com>
	 <20040315162954.GF655@holomorphy.com>
Content-Type: text/plain
Message-Id: <1079375451.8748.495.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 15 Mar 2004 13:30:51 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-15 at 11:29, William Lee Irwin III wrote:
> On Mon, 2004-03-15 at 03:05, William Lee Irwin III wrote:
> >> So I farted around for a hour or two seeing if I could get tiobench
> >> to do aio for the general purpose of exercising codepaths, benchmarking,
> >> etc. in simple ways. Hopefully this answers the need for regular,
> >> simple, and easily-available methods of exercising and/or benchmarking
> >> the aio code in some way.
> 
> On Mon, Mar 15, 2004 at 08:28:43AM -0500, Chris Mason wrote:
> > You might want to check out the list of benchmarks collected at:
> > http://lse.sourceforge.net/io/aio.html
> > I found that adapting existing benchmarks made it hard to test some of
> > the aio corner cases, so aio-stress is just a big state machine, with
> > options to tweak how badly you want to abuse the aio subsystem.  
> > There are a few other good ones on the page though.
> 
> Looks encouraging. What's the distro coverage like? deb doesn't have them.
> 

I doubt anyone ships packages for them.  LTP has integrated some aio
tests though.

-chris


