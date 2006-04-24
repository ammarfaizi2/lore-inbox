Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWDXXnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWDXXnb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 19:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWDXXnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 19:43:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:37349 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932110AbWDXXna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 19:43:30 -0400
From: Andi Kleen <ak@suse.de>
To: Jon Mason <jdmason@us.ibm.com>
Subject: Re: [PATCH] x86-64: trivial gart clean-up
Date: Tue, 25 Apr 2006 00:42:43 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, mulix@mulix.org
References: <20060424225342.GB14575@us.ibm.com>
In-Reply-To: <20060424225342.GB14575@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604250042.43910.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 April 2006 00:53, Jon Mason wrote:
> A trivial change to have gart_unmap_sg call gart_unmap_single directly,
> instead of bouncing through the dma_unmap_single wrapper in
> dma-mapping.h.  This change required moving the gart_unmap_single above
> gart_unmap_sg, and under gart_map_single (which seems a more logical
> place that its current location IMHO).

What advantage does that have? I think I prefer the old code.

-Andi

