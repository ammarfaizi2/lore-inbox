Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946369AbWJ0Kau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946369AbWJ0Kau (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 06:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946370AbWJ0Kau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 06:30:50 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:61872 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1946369AbWJ0Kat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 06:30:49 -0400
Message-ID: <4541DFD8.6010106@vmware.com>
Date: Fri, 27 Oct 2006 03:30:48 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>
Subject: Re: [PATCH 1/4] Prep for paravirt: move pagetable includes.
References: <1161920325.17807.29.camel@localhost.localdomain>
In-Reply-To: <1161920325.17807.29.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> Move header includes for the nopud / nopmd types to the location of the
> actual pte / pgd type definitions.  This allows generic 4-level page
> type code to be written before the split 2/3 level page table headers are
> included.
>
> Signed-off-by: Zachary Amsden <zach@vmware.com>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>   

I sent this one out previously .. I think it is already in a subsystem tree.

Zach
