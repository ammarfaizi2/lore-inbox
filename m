Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265632AbTIJTUS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265631AbTIJTSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:18:30 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:63927 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265609AbTIJTRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:17:23 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       rjwalsh@durables.org
In-Reply-To: <20030910090846.GI4489@waste.org>
References: <20030910074030.GC4489@waste.org>
	 <20030910004907.67b90bd1.akpm@osdl.org> <20030910081845.GF4489@waste.org>
	 <20030910083935.GG1532@krispykreme>  <20030910090846.GI4489@waste.org>
Message-Id: <1063221398.678.0.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 10 Sep 2003 21:16:38 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: [PATCH 1/3] netpoll api
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well I'll come up with something for x86 tomorrow and when helper
> macros materialize, I'll use them.

Or rahter, define a netpoll_find_irq_handler or something helper
macro and implement it for x86. Archs that want netpoll will
then have to implement their own. 

Ben.



