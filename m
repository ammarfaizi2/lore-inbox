Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263322AbUJ2Nr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbUJ2Nr3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 09:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263326AbUJ2Nr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 09:47:28 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:53764 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263322AbUJ2Np5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 09:45:57 -0400
Date: Fri, 29 Oct 2004 14:45:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drop IRDA ISA dependency
Message-ID: <20041029134549.GA12705@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@suse.de>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20041029130846.3D6639DF0EA9@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029130846.3D6639DF0EA9@verdi.suse.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 03:08:46PM +0200, Andi Kleen wrote:
> 
> Make IRDA devices are not really ISA devices not depend on CONFIG_ISA.
> This allows to use them on x86-64

but this is bogus.  If it's using isa-style DMA it needs CONFIG_ISA.

