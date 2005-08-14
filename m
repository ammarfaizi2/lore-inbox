Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbVHNPtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbVHNPtA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 11:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbVHNPtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 11:49:00 -0400
Received: from are.twiddle.net ([64.81.246.98]:63891 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S932548AbVHNPs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 11:48:59 -0400
Date: Sun, 14 Aug 2005 08:48:48 -0700
From: Richard Henderson <rth@twiddle.net>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/2] consolidate sys_ptrace
Message-ID: <20050814154848.GA4927@twiddle.net>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20050814093543.GA28557@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050814093543.GA28557@lst.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2005 at 11:35:43AM +0200, Christoph Hellwig wrote:
> This version has the arch_ptrace return value changes to long as
> recommended by Richard Henderson.
...
> +extern int arch_ptrace(struct task_struct *child, long request, long addr, long data);

No it doesn't.


r~
