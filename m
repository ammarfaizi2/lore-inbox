Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbVKRA3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVKRA3I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 19:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbVKRA3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 19:29:08 -0500
Received: from ns.suse.de ([195.135.220.2]:16863 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750706AbVKRA3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 19:29:07 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] x86-64: dma_ops for DMA mapping -K4
Date: Fri, 18 Nov 2005 01:28:03 +0100
User-Agent: KMail/1.8
Cc: Muli Ben-Yehuda <mulix@mulix.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Ravikiran G Thirumalai <kiran@scalex86.org>, niv@us.ibm.com,
       Jon Mason <jdmason@us.ibm.com>, Jimi Xenidis <jimix@watson.ibm.com>,
       Muli Ben-Yehuda <MULI@il.ibm.com>,
       "Shai Fultheim (shai@scalex86.org)" <shai@scalex86.org>
References: <20051117131622.GC11966@granada.merseine.nu> <20051117220348.GA9297@infradead.org>
In-Reply-To: <20051117220348.GA9297@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511180128.04096.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 November 2005 23:03, Christoph Hellwig wrote:

> Any chance you could move struct dma_mapping_ops to generic code and
> implement the dma_ operations ontop of them in linux/dma-mapping.h if
> the arch sets a WANT_DMA_MAPPING_OPS symbol?  This kind of switch is
> duplicated in far too many architectures.

If anything asm-generic, not ifdef.

-Andi
