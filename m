Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbTDQMOu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 08:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbTDQMOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 08:14:50 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:38662 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S261321AbTDQMOt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 08:14:49 -0400
Date: Thu, 17 Apr 2003 14:26:42 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: Network Latency problem 2.4.20 (may be related to cls_u32)
Message-ID: <Pine.LNX.4.51.0304171416590.30868@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

my 2.4.20 machine's network latency after some random ammount of time
increases and makes the processing of packets very slow.
The only cure for it I have devised is to do a
# /etc/init.d/networking restart

On LAN normally i get pings of 0.1 ms. When the machine is under these
conditions, i get results like: 200, 1000, 350, 1100 ms.

I am not sure but it may be related to the cls_u32 module because
I can not unload it after i remove the qdiscs/filters i set up.
Maybe there is a bug in it, maybe some memory is not free'd or something
related.

Anyway, do you have any advice on how to diagnose my problems?
The machine is not workloaded, localhost connections work ok.

Regards,
Maciej Soltysiak
