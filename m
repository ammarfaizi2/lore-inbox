Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318256AbSHSKwU>; Mon, 19 Aug 2002 06:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318268AbSHSKwT>; Mon, 19 Aug 2002 06:52:19 -0400
Received: from holomorphy.com ([66.224.33.161]:3275 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318256AbSHSKwT>;
	Mon, 19 Aug 2002 06:52:19 -0400
Date: Mon, 19 Aug 2002 03:55:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Subject: [BUG] 2.5.30 swaps with no swap device mounted!!
Message-ID: <20020819105520.GK18350@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the natural slab shootdown laziness issues, I turned off swap.
The kernel reported that it had successfully unmounted the swap device,
and for several days ran without it. Tonight, it went 91MB into swap
on the supposedly unmounted swap device!

Yeah, it's 2.5.30, but this wasn't a crashbox that did it, and no one's
touched swap for a while anyway.

I'm about to hit the sack, so hopefully someone else can look into it
while I'm resting. This one will probably be a PITA to reproduce and I
already shot down one bad bug tonight anyway.


Cheers,
Bill
