Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbTHYE3s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 00:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbTHYE3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 00:29:48 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:44164 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261423AbTHYE3r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 00:29:47 -0400
Date: Mon, 25 Aug 2003 05:29:33 +0100
From: Jamie Lokier <jamie@shareable.org>
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030825042933.GD20529@mail.jlokier.co.uk>
References: <20030818004313.T3708@schatzie.adilger.int> <Pine.LNX.4.44.0308172352470.20433-100000@dlang.diginsite.com> <bi465n$2f1$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bi465n$2f1$1@abraham.cs.berkeley.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wagner wrote:
> If you see a 64-bit values repeat twice in a row when querying a
> cryptographic pseudorandom generator, the crypto-PRNG is almost surely
> broken.

True.  However if you generate lots of 64-bit values and see a
collision between any two, that is much more likely.  See "birthday paradox".

I know you understand this, David.  Just so everyone else is clear,
because part of this thread is about locking problems (same result
within a short time), and part of this thread is about uniqueness
(collisions between any pair).

Enjoy,
-- Jamie
