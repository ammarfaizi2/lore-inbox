Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266667AbUAWW1p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 17:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266699AbUAWW1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 17:27:45 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:37127 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S266667AbUAWW1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 17:27:44 -0500
Date: Fri, 23 Jan 2004 23:27:36 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Eduard Roccatello <lilo@roccatello.it>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/ipv4/tcp.c little cleanup
Message-ID: <20040123222736.GA17651@alpha.home.local>
References: <200401222253.37426.lilo@roccatello.it> <20040122234833.GL545@alpha.home.local> <200401232103.05618.lilo@roccatello.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401232103.05618.lilo@roccatello.it>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 23, 2004 at 09:03:05PM +0100, Eduard Roccatello wrote:
> sysctl_max_syn_backlog is an int and max_qlen_log is a u8 (uint8_t).
> i think there is no problem with them.
> sysctl_max_syn_backlog max value is 1024 so max_qlen_log is just 9.
> 
> is it ok for you?

it's ok, thanks Eduard for this clarification.

Cheers,
Willy
