Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265273AbTL0A2H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 19:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265277AbTL0A2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 19:28:07 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:38619 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265273AbTL0A2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 19:28:05 -0500
From: "Jesus Arango" <jarango@cs.arizona.edu>
To: <linux-kernel@vger.kernel.org>
Subject: 802.11 header
Date: Fri, 26 Dec 2003 17:29:20 -0700
Message-ID: <002101c3cc10$78b1b100$0100a8c0@jarango>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
I need to know the HW header is passed to and from an 802.11 device
driver. Does the kernel copy a just a "struct ethhdr" into the socket
buffer or does the device driver expect a full 802.11 header ? If just
the "struct ethhdr", the who and where is it converted to a full 802.11
header.

 
I am writing a header compression protocol. My compressor is called by
dev_queue_xmit and my decompressor has its own ETH_P protocol. I would
like to know how the header is stored inside the socket buffer at this
two specific points.

Thanks
Jesus

