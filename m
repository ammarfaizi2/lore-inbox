Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVCRNxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVCRNxb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 08:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVCRNxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 08:53:31 -0500
Received: from mail3.euroweb.net.mt ([217.145.4.38]:25478 "EHLO
	mail3.euroweb.net.mt") by vger.kernel.org with ESMTP
	id S261597AbVCRNxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 08:53:30 -0500
Message-ID: <423ADD5B.5060708@euroweb.net.mt>
Date: Fri, 18 Mar 2005 14:53:31 +0100
From: "Josef E. Galea" <josefeg@euroweb.net.mt>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel space sockets
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to implement a UDP server in a kernel module. So far I have 
created the struct socket using sock_create_kern(), and used 
sock->ops->bind() on it. Now how do I send UDP datagrams? I looked at 
some code and found the function sock->ops->sendmsg() but I can't figure 
out where to put the destination address. I would appreciate it if 
someone could point me to some tutorial or sample code.

Thanks,
Josef
