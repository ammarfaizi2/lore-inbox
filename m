Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbVJCP6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbVJCP6A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbVJCP6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:58:00 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:41708 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932328AbVJCP56 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:57:58 -0400
Date: Mon, 3 Oct 2005 08:57:34 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Deepak Saxena <dsaxena@plexity.net>
cc: Linus Torvalds <torvalds@osdl.org>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MTD] kmalloc + memzero -> kzalloc conversion
In-Reply-To: <20051001050003.GD11137@plexity.net>
Message-ID: <Pine.LNX.4.62.0510030856250.8006@schroedinger.engr.sgi.com>
References: <20051001050003.GD11137@plexity.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2005, Deepak Saxena wrote:

 > We have the API, so use it.

Ummm. There is a patch in Andrew's tree that allows the use of __GFP_ZERO 
with slabs in the same way as the page allocator. With that functionality 
kmalloc_node will also be able to zero stuff.

