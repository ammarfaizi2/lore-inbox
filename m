Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbUACQzT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 11:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263880AbUACQzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 11:55:19 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:35346 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263868AbUACQzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 11:55:16 -0500
Date: Sat, 3 Jan 2004 17:55:12 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Marco Correia <mvc@netcabo.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why is rdtsc reporting wrong cpu cycles?
Message-ID: <20040103165512.GB3728@alpha.home.local>
References: <200401031548.40025.mvc@netcabo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401031548.40025.mvc@netcabo.pt>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Sat, Jan 03, 2004 at 03:48:39PM +0000, Marco Correia wrote:
 
> The problem is that the value I get dividing by my processor frequency (my 
> computer is a 650Mhz toshiba satellite pro 4340) is giving me about 1 hour 
> and I'm using the computer for about 4 fours.
> 
> Am I forgetting something obvious? I already googled around but I came to the 
> conclusion that only new P4 M processors are able to change speed. 

Perhaps it supports throttling. My mobile athlon supports this : 10000 times
a second, it is stopped for a certain amount of time, then resumed. Depending
on the throttling factor, I can even here it !

Cheers,
Willy

