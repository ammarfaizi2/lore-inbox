Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUCON1L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 08:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbUCON1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 08:27:11 -0500
Received: from ns.suse.de ([195.135.220.2]:38545 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261947AbUCON06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 08:26:58 -0500
Subject: Re: aio tiobench
From: Chris Mason <mason@suse.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040315080520.GC655@holomorphy.com>
References: <20040315080520.GC655@holomorphy.com>
Content-Type: text/plain
Message-Id: <1079357322.4186.377.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 15 Mar 2004 08:28:43 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-15 at 03:05, William Lee Irwin III wrote:
> So I farted around for a hour or two seeing if I could get tiobench
> to do aio for the general purpose of exercising codepaths, benchmarking,
> etc. in simple ways. Hopefully this answers the need for regular,
> simple, and easily-available methods of exercising and/or benchmarking
> the aio code in some way.

You might want to check out the list of benchmarks collected at:

http://lse.sourceforge.net/io/aio.html

I found that adapting existing benchmarks made it hard to test some of
the aio corner cases, so aio-stress is just a big state machine, with
options to tweak how badly you want to abuse the aio subsystem.  

There are a few other good ones on the page though.

-chris




