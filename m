Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbVK0SGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVK0SGr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 13:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbVK0SGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 13:06:47 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:32148 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751131AbVK0SGq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 13:06:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FHkDdLT/+7dj2fVH0SBeSRmHLMkYvEBy4L/LjyzZ/4zC0lu1czBI7YmeEhIaGRionR6vxOODTQKqi7zB1SGvkSMBFuKIz2eVkehPFgCQs+bC5QLMdZ7HlJ5BQshgIwca2jzP/n5apPggWbom04edxqLWCaz04YfPNF1Bkqi/J68=
Message-ID: <aec8d6fc0511271006v265a3537r6a90e7d53f706d26@mail.gmail.com>
Date: Sun, 27 Nov 2005 19:06:44 +0100
From: Mateusz Berezecki <mateuszb+lkml@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>
Subject: memory allocation for DMA operations from network interface
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello List,

My question is about DMA transfers from network device. I suspect
these transfers require allocating physically contiguous memory 
blocks. What is the proper way to allocate such contiguous memory for
DMA purposes inside the kernel? Also what is the proper and
architecture independent way to convert virtual address to physical
one?


kind regards
Mateusz Berezecki
