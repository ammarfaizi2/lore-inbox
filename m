Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbVKBJRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbVKBJRV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 04:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbVKBJRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 04:17:21 -0500
Received: from ozlabs.org ([203.10.76.45]:55947 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932693AbVKBJRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 04:17:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17256.33817.263105.197325@cargo.ozlabs.ibm.com>
Date: Wed, 2 Nov 2005 20:17:13 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org,
       trini@kernel.crashing.org
Subject: Re: [PATCH 1/2] slob: move kstrdup to lib/string.c
In-Reply-To: <20051102174020.37da0396.akpm@osdl.org>
References: <2.494767362@selenic.com>
	<20051102170053.1c120a03.akpm@osdl.org>
	<20051102070337.GC4367@waste.org>
	<20051102174020.37da0396.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> > That doesn't sound kosher, have a pointer?
> > 
> 
> http://lkml.org/lkml/2005/4/8/128

Yes, we currently use bits of lib/ in the zImage boot wrapper.  I
suspect we used to have our own string routines for the boot wrapper
until somebody said "why do we have all this code duplicated" and
cleaned it up. :)

Paul.
