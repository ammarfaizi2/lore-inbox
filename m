Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263923AbTLXV7x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 16:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263927AbTLXV7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 16:59:52 -0500
Received: from ms-smtp-02-qfe0.nyroc.rr.com ([24.24.2.56]:10693 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S263923AbTLXV7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 16:59:51 -0500
Message-ID: <3FEA0C3C.9090601@cs.oswego.edu>
Date: Wed, 24 Dec 2003 16:59:24 -0500
From: Keith Lea <keith@cs.oswego.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test11 data loss
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I'm not subscribed to this list. This is not a help request, and 
not really a bug report, I just thought someone should know about this.

I installed the 2.6.0-beta11-mm kernel last week, and the other day my 
computer locked up (this is normal on my laptop with every kernel 
version I've tried, this isn't the problem I'm posting about). When I 
restarted, many, many files that had been open when it locked up were 
filled with garbage, or the contents of totally unrelated files. For 
example, my syslog contained some KDE header file code, and 
/sbin/modprobe contained 82kb of data that seemed like random noise. I 
think each file was the same size as it was originally, just with 
different data, but I'm not sure.

The corruption happened on two separate partitions on a single IDE 
laptop drive, and both were ReiserFS 3.6 partitions. I don't know if 
this is a kernel bug or a Reiser bug or something else, but I thought 
the kernel developers should know about this, and be on the lookout for 
similar things (hopefully with more informative bug reports than mine). 
I'm sorry I don't have more information, but if anyone wants to know 
more about my system I'd be glad to help.

-Keith Lea
