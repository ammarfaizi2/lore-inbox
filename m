Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268314AbUGXGPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268314AbUGXGPt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 02:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268317AbUGXGPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 02:15:49 -0400
Received: from ozlabs.org ([203.10.76.45]:12991 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268314AbUGXGPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 02:15:48 -0400
Date: Sat, 24 Jul 2004 16:15:30 +1000
From: Anton Blanchard <anton@samba.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: akpm@osdl.org, paulus@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix ppc64 max_pfn issue
Message-ID: <20040724061530.GG4556@krispykreme>
References: <20040724044720.GF4556@krispykreme> <20040724060802.GA31385@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040724060802.GA31385@taniwha.stupidest.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Since we cap it at 1<<12 I guess the platform affected might be ARM
> where you would otherwise get a smaller hash size.  That said, I
> wonder if a shift of 12 suffices for really large machines with many
> many processes.

Yeah it does seem low considering how easy it is to create 100,000
threads these days.

Anton
