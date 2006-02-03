Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWBCE6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWBCE6Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 23:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWBCE6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 23:58:24 -0500
Received: from main.gmane.org ([80.91.229.2]:18640 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750944AbWBCE6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 23:58:23 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: yipee <yipeeyipeeyipeeyipee@yahoo.com>
Subject: Re: changing physical page
Date: Fri, 3 Feb 2006 04:58:07 +0000 (UTC)
Message-ID: <loom.20060203T055339-322@post.gmane.org>
References: A<loom.20060202T160457-366@post.gmane.org> <Pine.LNX.4.61.0602021047350.20707@chaos.analogic.com> <Pine.LNX.4.61.0602021138001.21010@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.69.73.167 (Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.1) Gecko/20060111 Firefox/1.5.0.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson <linux-os <at> analogic.com> writes:

[snip]
 
> If your program(s) rely upon being in some physical location,
> they are broken. Even with mlockall(), you just keep them
> where they are, not where you'd like them to be. If you
> are trying to DMA into/out-of user-space, there is only
> ONE way to do it. Your driver allocates DMA-able pages and
> your code mmaps() it into user-space. That way, the page(s)
> are always present and have the right attributes. If you
> malloc() something, then try to "convert" in the kernel
> through your driver, the code's broken.

And all this page-moving for getting contiguous DMA memory, happens today on
x86_64 kernels?
Can you please give me a pointer to the source code?


Thanks


