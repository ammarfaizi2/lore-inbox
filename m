Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbUCZVkM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 16:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbUCZVkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 16:40:11 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:32274 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261258AbUCZVkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 16:40:09 -0500
Date: Fri, 26 Mar 2004 21:40:07 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm4
Message-ID: <20040326214007.A10869@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040326131816.33952d92.akpm@osdl.org> <20040326132212.14bac327.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040326132212.14bac327.akpm@osdl.org>; from akpm@osdl.org on Fri, Mar 26, 2004 at 01:22:12PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 01:22:12PM -0800, Andrew Morton wrote:
> +si_band-is-long.patch
> 
>  Make the siginfo si_band field unsigned long.

Do we still need __ARCH_SI_BAND_T with this one?

> +dont-show-cdroms-in-proc-partitions.patch
> 
>  Suppress cdroms in /proc/partitions

What's this patch trying to archive?  IDE cdroms are partitionable in
2.5..

