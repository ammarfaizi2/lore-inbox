Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbTLPIQj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 03:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbTLPIQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 03:16:38 -0500
Received: from web20106.mail.yahoo.com ([216.136.226.43]:20809 "HELO
	web20106.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264371AbTLPIQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 03:16:37 -0500
Message-ID: <20031216081636.94723.qmail@web20106.mail.yahoo.com>
Date: Tue, 16 Dec 2003 00:16:36 -0800 (PST)
From: Vidya G Krishnan <vgk_vgk@yahoo.com>
Subject: Packet Handling in Linux
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am doing a project on traffic shaping in linux. I
think of inserting a module on top of network driver
in gateway, buffer packets obtained from network
driver and transmit according to prefixed rate to
other machines.

How can I call my packet handling function instead of
the default packet handler(say IPV4 packet handler)?
Is it possible to call my packet handler by changing
the net_rx_action() in linux/net/core/dev.c . Can I
modify the ETH_P_IP (default function is ip_rcv() in
linux/ip_input.c). 

My idea is to call ip_rcv() from my packet handler. Do
u think it will work? Can u suggest a better one? 

plzzz reply...



__________________________________
Do you Yahoo!?
New Yahoo! Photos - easier uploading and sharing.
http://photos.yahoo.com/
