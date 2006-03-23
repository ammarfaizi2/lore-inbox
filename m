Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965044AbWCWLvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbWCWLvX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 06:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965322AbWCWLvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 06:51:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53148 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965308AbWCWLvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 06:51:20 -0500
Date: Thu, 23 Mar 2006 03:47:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       linux-mm@kvack.org, wli@holomorphy.com
Subject: Re: mm/hugetlb.c/alloc_fresh_huge_page(): slow division on NUMA
Message-Id: <20060323034750.2ba076f0.akpm@osdl.org>
In-Reply-To: <20060323110831.GA14855@rhlx01.fht-esslingen.de>
References: <20060323110831.GA14855@rhlx01.fht-esslingen.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
>
> on NUMA there
>  indeed is an idiv opcode in the mm/hugetlb.o output:
> 
>   138:   e8 fc ff ff ff          call   139 <alloc_fresh_huge_page+0x32>

Stop looking at ancient 2.6.16 kernels.  That code isn't there any more ;)
