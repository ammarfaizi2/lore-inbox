Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbVIDAn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbVIDAn6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 20:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbVIDAn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 20:43:58 -0400
Received: from mail1.bizmail.net.au ([202.162.77.164]:64154 "EHLO
	mail1.bizmail.net.au") by vger.kernel.org with ESMTP
	id S1751137AbVIDAn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 20:43:58 -0400
Message-ID: <431A4333.6000101@bizmail.com.au>
Date: Sun, 04 Sep 2005 10:43:31 +1000
From: YH <yh@bizmail.com.au>
Reply-To: yh@bizmail.com.au
Organization: yh@bizmail.com.au, yhus@suers.sf.net, yudeh@rtunet.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: advice
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Apologize for off topic questions. While I am working on a device driver 
in kernel 2.4.21, I need advices from kernel developers.

1. When the read() or write() is called from user applications, the 
driver can either have a static buffer with limited size or dynamic 
memory allocation (kmalloc).

The static buffer is simple and reliable, but limited buffer size to 
applications.

Personally, I would like to use dynamic kernel memory allocation 
(kmalloc), the question is whether it could be any issues (reliability) 
to frequently call kmalloc / kfree in a high speed device (100mpbs)?

2. Although there is a mechanism for user applications to access the 
driver through function call read(), write(), or ioctl(). Can the 
application passes a callback pointer to the driver in kernel space so 
that the driver can call the callback function when some special event 
is received. Or if there is a mechanism to let the driver to send a 
notification to the user application?

Thank you and appreciate your helps.

Jim

