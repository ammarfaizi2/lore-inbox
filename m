Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbUK0G7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbUK0G7H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 01:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbUK0G6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 01:58:46 -0500
Received: from zeus.kernel.org ([204.152.189.113]:24255 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261558AbUKZTJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:09:15 -0500
Message-ID: <41A5E0F7.5040704@euroweb.net.mt>
Date: Thu, 25 Nov 2004 14:41:11 +0100
From: "Josef E. Galea" <josefeg@euroweb.net.mt>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Socket buffers.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am sending and receiving data using socket buffers. On the receiving 
end, I have registered a packet handler using dev_add_pack() and am only 
processing packets of type PACKET_HOST. Now I want to read the source 
MAC address of the incoming packets, and I am using memcpy(src, 
(skb->mac.ethernet + 6), 6). However, when I try to print the value of 
src, I am getting garbage data. Can anyone help?

Thanks
Josef E. Galea
