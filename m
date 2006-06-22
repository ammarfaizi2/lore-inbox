Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751529AbWFVANP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbWFVANP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 20:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbWFVANP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 20:13:15 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:18381 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751498AbWFVANO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 20:13:14 -0400
Date: Wed, 21 Jun 2006 17:12:52 -0700
From: Paul Jackson <pj@sgi.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1 : two PF flags with the same value
Message-Id: <20060621171252.d14e511e.pj@sgi.com>
In-Reply-To: <4499D8C4.5040304@bigpond.net.au>
References: <20060621034857.35cfe36f.akpm@osdl.org>
	<4499D8C4.5040304@bigpond.net.au>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> #define PF_SPREAD_SLAB	0x02000000	/* Spread some slab caches over cpuset */
> ...
> #define PF_MUTEX_TESTER	0x02000000	/* Thread belongs to the rt mutex 

Thanks for noticing, Peter.

> ahem.   Will fix, thanks.

Good - thanks, Andrew.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
