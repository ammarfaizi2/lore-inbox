Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbUBWJXv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 04:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbUBWJXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 04:23:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:3020 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261895AbUBWJXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 04:23:49 -0500
Date: Mon, 23 Feb 2004 01:24:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vm-fix-all_zones_ok (was Re: 2.6.3-mm3)
Message-Id: <20040223012430.25476691.akpm@osdl.org>
In-Reply-To: <4039C609.7040307@cyberone.com.au>
References: <20040222172200.1d6bdfae.akpm@osdl.org>
	<40395ACE.4030203@cyberone.com.au>
	<20040222175507.558a5b3d.akpm@osdl.org>
	<40396ACD.7090109@cyberone.com.au>
	<40396DA7.70200@cyberone.com.au>
	<4039B4E6.3050801@cyberone.com.au>
	<4039BE41.1000804@cyberone.com.au>
	<20040223005948.10a3b325.akpm@osdl.org>
	<4039C609.7040307@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> >I wouldna spotted that in a million years.  That all_zones_ok code was a
>  >bitch to test and really needs retesting.
>  >
>  >
> 
>  all_zones_ok is actually now the only way you can really stop
>  scanning (yes, you eventually run out of priority).
> 
>  I suspect you mean zone->all_unreclaimable?

yes.
