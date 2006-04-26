Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWDZL3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWDZL3V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 07:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWDZL3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 07:29:21 -0400
Received: from cantor2.suse.de ([195.135.220.15]:22742 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932395AbWDZL3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 07:29:20 -0400
From: Andi Kleen <ak@suse.de>
To: Jon Mason <jdmason@us.ibm.com>
Subject: Re: [PATCH] x86-64: trivial gart clean-up
Date: Wed, 26 Apr 2006 13:29:13 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, mulix@mulix.org
References: <20060424225342.GB14575@us.ibm.com>
In-Reply-To: <20060424225342.GB14575@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604261329.13572.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 April 2006 00:53, Jon Mason wrote:
> A trivial change to have gart_unmap_sg call gart_unmap_single directly,
> instead of bouncing through the dma_unmap_single wrapper in
> dma-mapping.h.  This change required moving the gart_unmap_single above
> gart_unmap_sg, and under gart_map_single (which seems a more logical
> place that its current location IMHO).

Merged thanks.
-Andi
