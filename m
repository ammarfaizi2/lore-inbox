Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVAMTyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVAMTyn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 14:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVAMTv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:51:27 -0500
Received: from [213.146.154.40] ([213.146.154.40]:43928 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261442AbVAMTsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:48:13 -0500
Date: Thu, 13 Jan 2005 19:48:07 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christian Borntraeger <cborntra@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] reintroduce EXPORT_SYMBOL(task_nice) for binfmt_elf32
Message-ID: <20050113194807.GA28010@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christian Borntraeger <cborntra@de.ibm.com>,
	linux-kernel@vger.kernel.org,
	Arjan van de Ven <arjan@infradead.org>,
	Andrew Morton <akpm@osdl.org>
References: <200501132042.31215.cborntra@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501132042.31215.cborntra@de.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 08:42:30PM +0100, Christian Borntraeger wrote:
> export was the fact, that binfmt_elf is no longer modular. Unfortunately 
> that is not true in the emulation case on s390 and (untested) sparc64. 

I'd suggest putting it under CONFIG_COMPAT.

