Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161379AbWALWqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161379AbWALWqf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161383AbWALWqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:46:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61620 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161379AbWALWqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:46:33 -0500
Date: Thu, 12 Jan 2006 14:46:02 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [git patches] 2.6.x net driver updates
In-Reply-To: <20060112143938.5cf7d6a5.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0601121444030.3535@g5.osdl.org>
References: <20060112221322.GA25470@havoc.gtf.org> <Pine.LNX.4.64.0601121423120.3535@g5.osdl.org>
 <20060112143938.5cf7d6a5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Jan 2006, Andrew Morton wrote:
> 
> Yes, I think that's much more Aunt-Nellie-friendly, but Roman considers it
> abuse of the Kconfig system in ways which I never completely understood?

Hmm. If Roman dislikes it, he must dislike the fact that we already do 
exactly this for a ton of different things. There's something like 2000+ 
"select" statements in the kernel Kconfig tree, and just grepping for 
"select.*CRYPTO" gets 52 hits..

So this isn't new..

		Linus
