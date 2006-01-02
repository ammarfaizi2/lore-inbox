Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWABPJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWABPJL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 10:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWABPJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 10:09:11 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:11912 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750756AbWABPJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 10:09:10 -0500
Date: Mon, 2 Jan 2006 17:09:04 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andi Kleen <ak@suse.de>
cc: Denis Vlasenko <vda@ilport.com.ua>, Eric Dumazet <dada1@cosmosbay.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull on
 x86_64 machines ?
In-Reply-To: <200601021456.23253.ak@suse.de>
Message-ID: <Pine.LNX.4.58.0601021707290.21827@sbz-30.cs.Helsinki.FI>
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net> <200601021345.44843.ak@suse.de>
 <Pine.LNX.4.58.0601021447440.22227@sbz-30.cs.Helsinki.FI> <200601021456.23253.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jan 2006, Andi Kleen wrote:
> I wasn't proposing fully dynamic slabs, just a better default set
> of slabs based on real measurements instead of handwaving (like
> the power of two slabs seemed to have been generated). With separate
> sets for 32bit and 64bit. 
> 
> Also the goal wouldn't be better performance, but just less waste of memory.
> 
> I suspect such a move could save much more memory on small systems 
> than any of these "make fundamental debugging tools a CONFIG" patches ever.

I misunderstood what you were proposing. Sorry. It makes sense to measure 
it.

			Pekka
