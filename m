Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVA3RZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVA3RZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 12:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbVA3RZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 12:25:57 -0500
Received: from waste.org ([216.27.176.166]:53224 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261740AbVA3RZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 12:25:52 -0500
Date: Sun, 30 Jan 2005 09:25:39 -0800
From: Matt Mackall <mpm@selenic.com>
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: Fruhwirth Clemens <clemens-dated-1107431870.41eb@endorphin.org>,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/04] Add LRW
Message-ID: <20050130172539.GG2891@waste.org>
References: <20050124115750.GA21883@ghanima.endorphin.org> <20050130000221.GA2955@waste.org> <1107085769.13776.11.camel@ghanima>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107085769.13776.11.camel@ghanima>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 12:49:29PM +0100, Fruhwirth Clemens wrote:
> 
> In fact, it's lowerCamelCase, that's intentional.

The problem with mixing of naming styles is that it becomes
difficult to remember what style is used where. Is it foo_bar_baz() or
foobarbaz() or fooBarBaz() or FooBarBaz()? 

> > LRW and the GF(2**128) code is not configurable?
> 
> No, it's a cipher mode. None of the modes is configurable.

Is LRW an appropriate mode for anything but block storage?

-- 
Mathematics is the supreme nostalgia of our time.
