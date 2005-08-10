Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965219AbVHJRIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965219AbVHJRIp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 13:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965216AbVHJRIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 13:08:45 -0400
Received: from are.twiddle.net ([64.81.246.98]:64402 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S965212AbVHJRIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 13:08:44 -0400
Date: Wed, 10 Aug 2005 10:08:37 -0700
From: Richard Henderson <rth@twiddle.net>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] consolidate sys_ptrace
Message-ID: <20050810170837.GA25403@twiddle.net>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20050810080057.GA5295@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050810080057.GA5295@lst.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 10:00:57AM +0200, Christoph Hellwig wrote:
> Some architectures have a too different ptrace so we have to exclude
> them: alpha...

Alpha could be updated to use this, I think.  Just a matter of
using force_successful_syscall_return instead of pt_regs directly.

I'll have a look at testing this.


r~
