Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264428AbTDYVCH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 17:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbTDYVCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 17:02:07 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:11187 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264428AbTDYVB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 17:01:59 -0400
Date: Fri, 25 Apr 2003 23:14:05 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: rmoser <mlmoser@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swap Compression
Message-ID: <20030425211405.GC8958@wohnheim.fh-wedel.de>
References: <200304251640110420.0069172B@smtp.comcast.net> <200304251648150320.007079A7@smtp.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200304251648150320.007079A7@smtp.comcast.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 April 2003 16:48:15 -0400, rmoser wrote:
> 
> Sorry if this is HTML mailed.  I don't know how to control those settings

It is not, but if you could limit lines to <80 characters, that would
be nice.

> COMPRESSED SWAP
> 
> This is mainly for things like linux on iPaq (handhelds.org) and
> people who like to play (me :), but how about compressed swap and
> RAM as swap?  To be plausable, we need a very fast compression
> algorithm.  I'd say use the following back pointer algorithm (this
> is headerless and I coded a decompressor in 6502 assembly in about
> 315 bytes) and 100k block sizes (compress streams of data until they
> are 100k in size, then stop.  Include the cap at the end in the
> 100k).
> 
> [...]
> 
> CONCLUSION
> 
> I think compressed swap and swap-on-ram with compression would be a
> great idea, especially for embedded systems.  High-performance
> systems that can handle the compression/decompression without
> blinking would especially benefit, as the swap-on-ram feature would
> give an almost seamless RAM increase.  Low-performance systems would
> take a performance hit, but embedded devices would still benefit
> from the swap-on-ram with compression RAM boost, considering they
> can probably handle the algorithm.  I am looking forward to seeing
> this implimented in 2.4 and 2.5/2.6 if it is adopted.

Nice idea. This might even benefit normal pc style boxes, if the
performance loss through compression is overcompensated by io gains
(less data transferred).

The tiny problem I see is that most people here have tons of whacky
ideas themselves but lack the time to actually implement them. If you
really want to get it done, do it yourself. It doesn't have to be
perfect, if it works in principle and appears to be promising, you
will likely receive enough help to finish it. But you have to get
there first.

At least, that is how it usually works. Feel free to prove me wrong.

Jörn

-- 
When in doubt, use brute force.
-- Ken Thompson
