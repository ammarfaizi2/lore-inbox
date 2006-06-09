Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWFIPBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWFIPBN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWFIPBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:01:13 -0400
Received: from ik55118.ikexpress.com ([213.246.55.118]:3201 "EHLO
	ik55118.ikexpress.com") by vger.kernel.org with ESMTP
	id S1030199AbWFIPBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:01:12 -0400
Message-ID: <44898D29.4030405@free-electrons.com>
Date: Fri, 09 Jun 2006 17:00:57 +0200
From: Michael Opdenacker <michael-lists@free-electrons.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060522)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Plans to obsolete register_chrdev()?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In Linux 2.6, character device driver developers are supposed to use 
alloc_chrdev_region() and cdev_add() instead of register_chrdev(). See 
http://lwn.net/images/pdf/LDD3/ch03.pdf or http://lwn.net/Articles/126808/ .

However, in 2.6.16, there are still *very few* uses of cdev_add(). 
Compare http://lxr.free-electrons.com/ident?i=cdev_add to 
http://lxr.free-electrons.com/ident?i=register_chrdev .

Are there plans to officially obsolete register_chrdev() (in particular 
through Documentation/feature-removal-schedule.txt)?

Unless register_chrdev() is supposed to stay, I'll be glad to 
participate in converting character driver code. In particular, would 
updateds to drivers/chars/mem.c file be welcome?

Cheers,

    Michael.

-- 
Michael Opdenacker, Free Electrons
Free Embedded Linux Training Materials
on http://free-electrons.com/training
(More than 1000 pages!)

