Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263225AbTDLKCO (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 06:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263226AbTDLKCO (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 06:02:14 -0400
Received: from [203.197.168.150] ([203.197.168.150]:19466 "HELO
	mailscanout256k.tataelxsi.co.in") by vger.kernel.org with SMTP
	id S263225AbTDLKCN (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 06:02:13 -0400
Message-ID: <3E97E6B1.60808@tataelxsi.co.in>
Date: Sat, 12 Apr 2003 15:43:05 +0530
From: "Sriram Narasimhan" <nsri@tataelxsi.co.in>
Organization: Tata Elxsi
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Free Physical & kmalloc
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am trying to allocate memory from a driver using GFP_KERNEL.
The allocation fails if I try to allocate more than what is physically free.
What ever memory is free is available in the free buffers/cache.

Why is this happening ? How do I allocate more memory than what is 
available in the 'free physical'.
Shouldn't kmalloc take care of flushing free buffers/cache to free 
physical when there is a memory allocation requirement ?

I am running 2.4.7-10 RH7.2 on i386.

Any suggestions or pointers could be very helpful.

Thank you.
Regards,
Sriram

