Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWDJRWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWDJRWt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 13:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWDJRWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 13:22:49 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:57494 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751228AbWDJRWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 13:22:48 -0400
Date: Mon, 10 Apr 2006 10:22:34 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Dave McCracken <dmccr@us.ibm.com>
cc: Hugh Dickins <hugh@veritas.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Adam Litke <agl@us.ibm.com>, wli@holomorphy.com
Subject: Re: [RFC/PATCH] Shared Page Tables [0/2]
In-Reply-To: <1144685588.570.35.camel@wildcat.int.mccr.org>
Message-ID: <Pine.LNX.4.64.0604101020230.22947@schroedinger.engr.sgi.com>
References: <1144685588.570.35.camel@wildcat.int.mccr.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Apr 2006, Dave McCracken wrote:

> Here's a new cut of the shared page table patch.  I divided it into
> two patches.  The first one just fleshes out the
> pxd_page/pxd_page_kernel macros across the architectures.  The
> second one is the main patch.
> 
> This version of the patch should address the concerns Hugh raised.
> Hugh, I'd appreciate your feedback again.  Did I get everything?
> 
> These patches apply against 2.6.17-rc1.

Could you break out the locking changes to huge pages?
