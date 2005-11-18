Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbVKREcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbVKREcf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 23:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbVKREcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 23:32:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:29331 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932478AbVKREcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 23:32:35 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [PATCH] NUMA policies in the slab allocator V2
Date: Fri, 18 Nov 2005 05:31:47 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@osdl.org
References: <Pine.LNX.4.62.0511171745410.22486@schroedinger.engr.sgi.com> <200511180359.17598.ak@suse.de> <Pine.LNX.4.62.0511171925090.22785@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0511171925090.22785@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511180531.47764.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 November 2005 04:38, Christoph Lameter wrote:
> You really want to run the useless fastpath? Examine lists etc for
> the local node despite the policy telling you to get off node?

Yes.

> Hmm. Is a hugepage ever allocated from interrupt context?

They aren't.

-Andi
