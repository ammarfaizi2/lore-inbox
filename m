Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262086AbVAJFE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVAJFE6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 00:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbVAJFE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:04:58 -0500
Received: from holomorphy.com ([207.189.100.168]:25225 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262086AbVAJFE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:04:56 -0500
Date: Sun, 9 Jan 2005 21:04:41 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PPC64] Hugepage bugfix
Message-ID: <20050110050441.GA2696@holomorphy.com>
References: <20050110155520.GA22101@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110155520.GA22101@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 02:55:20AM +1100, David Gibson wrote:
> Andrew, Linus, please apply:
> Fix a stupid unbalanced lock bug in the ppc64 hugepage code.  Lead
> rapidly to a crash if both CONFIG_HUGETLB_PAGE and CONFIG_PREEMPT were
> enabled (even without actually using hugepages at all).
> Signed-off-by: David Gibson <dwg@au1.ibm.com>

Acked-by: William Irwin <wli@holomorphy.com>
