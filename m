Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265377AbUBEQGC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 11:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265362AbUBEQGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 11:06:02 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:65416 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S265377AbUBEQET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 11:04:19 -0500
Date: Thu, 5 Feb 2004 17:04:15 +0100 (MET)
From: Mattias Wadenstein <maswan@acc.umu.se>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Performance issue with 2.6 md raid0
In-Reply-To: <402263E7.6010903@cyberone.com.au>
Message-ID: <Pine.A41.4.58.0402051647460.28218@lenin.acc.umu.se>
References: <Pine.A41.4.58.0402051304410.28218@lenin.acc.umu.se>
 <402263E7.6010903@cyberone.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Feb 2004, Nick Piggin wrote:

> Mattias Wadenstein wrote:
>
> >Greetings.
> >
> >While testing a file server to store a couple of TB in resonably large
> >files (>1G), I noticed an odd performance behaviour with the md raid0 in a
> >pristine 2.6.2 kernel as compared to a 2.4.24 kernel.
> >
> >When striping two md raid5:s, instead of going from about 160-200MB/s for
> >a single raid5 to 300M/s for the raid0 in 2.4.24, the 2.6.2 kernel gave
> >135M/s in single stream read performance.
>
> Can you try booting with elevator=deadline please?

Ok, then I get 253267 kB/s write and 153187 kB/s read from the raid0. A
bit better, but still nowhere near the 2.4.24 numbers.

For a single raid5, 158028 kB/s write and 162944 kB/s read.

/Mattias Wadenstein
