Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVF0Ov2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVF0Ov2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 10:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVF0OtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 10:49:19 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:10445 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261199AbVF0MpV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:45:21 -0400
References: <84144f0205062223226d560e41@mail.gmail.com>
            <42BB0151.3030904@suse.de>
            <20050623114318.5ae13514.akpm@osdl.org>
            <20050623193247.GC6814@suse.de>
            <1119717967.9392.2.camel@localhost>
            <20050627072449.GF19550@suse.de>
            <20050627072832.GA14251@wotan.suse.de>
            <Pine.LNX.4.58.0506271048310.26869@sbz-30.cs.Helsinki.FI>
            <20050627082046.GC14251@wotan.suse.de>
            <Pine.LNX.4.58.0506271525240.3200@sbz-30.cs.Helsinki.FI>
            <20050627123821.GE14251@wotan.suse.de>
In-Reply-To: <20050627123821.GE14251@wotan.suse.de>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Andi Kleen <ak@suse.de>
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>, Jeff Mahoney <jeffm@suse.de>,
       penberg@gmail.com, reiser@namesys.com, flx@namesys.com, zam@namesys.com,
       vs@thebsh.namesys.com, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com, joern@wohnheim.fh-wedel.de
Subject: Re: verbose BUG_ON reporting
Date: Mon, 27 Jun 2005 15:45:12 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42BFF4D8.000010AF@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
> It's still useless - it is too bloated to turn on by default
> and then if you need it you still won't have it.  And when you
> explicitely turn it on then you likely don't need it because
> you control the source.

Hmm. Would a BUG_ON_WITH_TEXT be a better solution? The home-grown assert 
macro in reiser4 can't be a long-term solution if people really want this 
kind of functionality. Btw, the bloat argument applies to assertion codes 
too. 

                   Pekka 
