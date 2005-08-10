Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965113AbVHJNej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbVHJNej (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 09:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965108AbVHJNej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 09:34:39 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:51460 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S965111AbVHJNeh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 09:34:37 -0400
Date: Wed, 10 Aug 2005 09:28:05 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] consolidate sys_ptrace
Message-ID: <20050810132805.GA3821@ccure.user-mode-linux.org>
References: <20050810080057.GA5295@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050810080057.GA5295@lst.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 10:00:57AM +0200, Christoph Hellwig wrote:
> The sys_ptrace boilerplate code (everything outside the big switch
> statement for the arch-specific requests) is shared by most
> architectures.  This patch moves it to kernel/ptrace.c and leaves the
> arch-specific code as arch_ptrace.

OK for UML.

		Jeff
