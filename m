Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWFKKQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWFKKQU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 06:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbWFKKQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 06:16:20 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:11415 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750862AbWFKKQT (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 06:16:19 -0400
Date: Sun, 11 Jun 2006 12:15:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: rohitseth@google.com, Andrew Morton <akpm@osdl.org>, Linux-mm@kvack.org,
       Linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Adding a counter in vma to indicate the number of
 physical pages backing it
In-Reply-To: <448A762F.7000105@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0606111215070.13585@yvahk01.tjqt.qr>
References: <1149903235.31417.84.camel@galaxy.corp.google.com>
 <448A762F.7000105@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> There is currently /proc/<pid>/smaps that prints the detailed
>> information about the usage of physical pages but that is a very
>> expensive operation as it traverses all the PTs (for some one who is
>> just interested in getting that data for each vma).
>
> Yet more cacheline footprint in the page fault and unmap paths...
>
> What is this used for and why do we want it? Could you do some
> smaps-like interface that can work on ranges of memory, and
> continue to walk pagetables instead?
>
BTW, what is smaps used for (who uses it), anyway?


Jan Engelhardt
-- 
