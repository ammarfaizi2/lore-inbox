Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313288AbSDOVUN>; Mon, 15 Apr 2002 17:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313297AbSDOVUK>; Mon, 15 Apr 2002 17:20:10 -0400
Received: from imladris.infradead.org ([194.205.184.45]:7940 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S313288AbSDOVTI>; Mon, 15 Apr 2002 17:19:08 -0400
Date: Mon, 15 Apr 2002 22:18:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        wli@holomorphy.com
Subject: Re: [PATCH] for_each_zone / for_each_pgdat
Message-ID: <20020415221809.A22149@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
	wli@holomorphy.com
In-Reply-To: <Pine.LNX.4.44L.0204151755491.16531-100000@duckman.distro.conectiva> <Pine.LNX.4.33.0204151400200.13034-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2002 at 02:08:54PM -0700, Linus Torvalds wrote:
> Which requires the user to use something like
> 
> 	for_each_zone(zone) {
> 		...
> 	} end_zone;
> 
> but doesn't need changing the double loop into a artificial single loop.

Bah, wli's version is so much nicer to use - in my eyes that justifies
the additional complexity in the macro.
