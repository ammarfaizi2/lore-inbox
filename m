Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbULXQYC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbULXQYC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 11:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbULXQYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 11:24:02 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:63106 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261234AbULXQX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 11:23:58 -0500
Date: Fri, 24 Dec 2004 08:24:03 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Brian Gerst <bgerst@didntduck.org>
cc: linux-ia64@vger.kernel.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Prezeroing V2 [1/4]: __GFP_ZERO / clear_page() removal
In-Reply-To: <41CB25AE.6010109@didntduck.org>
Message-ID: <Pine.LNX.4.58.0412240823240.6561@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
 <41C20E3E.3070209@yahoo.com.au> <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231132170.31791@schroedinger.engr.sgi.com>
 <41CB25AE.6010109@didntduck.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Dec 2004, Brian Gerst wrote:

> This part is wrong.  kmalloc() uses the slab allocator instead of
> getting a full page.

Thanks for finding that. V3 will have that fixed.
