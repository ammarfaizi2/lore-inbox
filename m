Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271047AbTGVXyx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 19:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271048AbTGVXyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 19:54:53 -0400
Received: from bay2-f83.bay2.hotmail.com ([65.54.247.83]:18449 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S271047AbTGVXyw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 19:54:52 -0400
X-Originating-IP: [147.145.40.43]
X-Originating-Email: [sumanesh@hotmail.com]
From: "sumanesh samanta" <sumanesh@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4x - getting physical address for pages in HIGHMEM 
Date: Wed, 23 Jul 2003 00:09:54 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY2-F83zgm7hVTThPD00010aa2@hotmail.com>
X-OriginalArrivalTime: 23 Jul 2003 00:09:57.0275 (UTC) FILETIME=[C0076EB0:01C350AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am facing a lot of problems in trying to get the physical address(actually 
bus address) from of page.

The most obvious answer, virt_to_bus(kmap(page)) seems to work for pages 
that are NOT  in high memory.

For pages in high memory, I have read up a lot of documentation, and mailing 
list questions, but the only thing that seems to work for me is,
(page-mem_map)<<PAGE_SHIFT

Now, the mail i got this from says that this would work only when  mem_map 
[] starts at zero.

I am pretty confused here, this seems to be a obvious problem, why does 
Linux not have a pretty macro or function that would work in all situations?

PS. please cc me in any answers, as I am not subscribed to this list.

Thanks
sumanesh

_________________________________________________________________
Protect your PC - get McAfee.com VirusScan Online  
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963

