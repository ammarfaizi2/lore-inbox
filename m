Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161185AbWASDMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161185AbWASDMm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 22:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161186AbWASDMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 22:12:42 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:61352 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161185AbWASDMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 22:12:41 -0500
Date: Wed, 18 Jan 2006 19:11:57 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Mundt <lethal@linux-sh.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, an Molton <spyro@f2s.com>,
       tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com,
       david-b@pacbell.net, Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] bitmap: Support for pages > BITS_PER_LONG.
Message-Id: <20060118191157.f653b09d.pj@sgi.com>
In-Reply-To: <20060119014812.GB18181@linux-sh.org>
References: <20060119014812.GB18181@linux-sh.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James,

The patch in this lkml thread from Paul Mundt looks to extend
the lib/bitmap.c bitmap_find_free_region() and related
routines that you added in June 2004.  This current patch
extends this code to handle more than a page worth of bits.

I added the others to the CC list because they were on your CC
list on your patch:

    Subject: [PATCH] provide x86 implementation of on-chip coherent memory API
	    for DMA
    From: James Bottomley <James.Bottomley@steeleye.com>
    Date:   30 Jun 2004 21:52:24 -0500

Could you look Mundt's patch, and see if it looks ok?

Thanks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
