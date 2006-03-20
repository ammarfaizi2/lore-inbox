Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965677AbWCTQBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965677AbWCTQBf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWCTQBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:01:34 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:29580 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965670AbWCTQBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:01:18 -0500
Date: Mon, 20 Mar 2006 08:01:01 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 02/23] radixtree: look-aside cache
In-Reply-To: <20060319023449.288540000@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0603200754540.21825@schroedinger.engr.sgi.com>
References: <20060319023413.305977000@localhost.localdomain>
 <20060319023449.288540000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Mar 2006, Wu Fengguang wrote:

> Signed-off-by: Christoph Lameter <clameter@sgi.com>

Hmm... This signoff exists because you are using some bit of earlier 
patches by me?

Typically the _node endings mean that one can specify a node number where 
to allocate memory.

Wont partial lookups like this complicate further work on the radixtree? 
Could you  get your speed optimizations into radixtree.c so that others 
can use it in the future?
