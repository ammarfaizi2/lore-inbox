Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbUDBWmx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 17:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUDBWmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 17:42:52 -0500
Received: from newport.ucsd.edu ([132.239.73.89]:59795 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261253AbUDBWmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 17:42:50 -0500
Message-ID: <406DEC69.6010909@physics.ucsd.edu>
Date: Fri, 02 Apr 2004 14:42:49 -0800
From: Terrence Martin <tmartin@physics.ucsd.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bigphysarea patch and 2.6, advice requested
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been asked to investigate the 2.6 kernel for a high performance 
computing application. One of the questions we have is whether or not 
2.6 supports the so called "bigphysarea" patch, or "hack" as it is 
sometimes referred to or has some built in mechanism to accomplish the 
same ends, large contiguous blocks of memory suitable for DMA.

The problem is that the project would like to use large contiguous areas 
of memory for the purposes of DMA for various custom made PCI cards. I 
have read in a couple of posts that when the PCI device supports 
scatter/gather that is the preferred mechanism. The issue is that there 
is a very good chance that not all of the devices have the 
scatter/gather mechanism implemented on board.

Is there anything in 2.6 that accomplishes the same ends as the 2.4 
based bigphysarea patch/hack?  What are other people doing when they 
need this functionality and also want to run 2.6?

Thanks for any insight you can provide.

Terrence Martin
UCSD Physics
