Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbTDOIJb (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 04:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264399AbTDOIJa (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 04:09:30 -0400
Received: from mail.ithnet.com ([217.64.64.8]:19467 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S264398AbTDOIJ3 (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 04:09:29 -0400
Date: Tue, 15 Apr 2003 10:21:09 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: How to configure an ethernet dev as PtP ?
Message-Id: <20030415102109.4802ddd0.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I tried to configure an ethernet device as a pointopoint link recently, just to
find out that this does not work as one would expect via:

ifconfig eth0 192.168.1.1 pointopoint 192.168.5.1 up

I tried on kernel 2.4.21-pre6 and 2.2.19 (just to name two), both the same. It
comes up as:

eth0      Link encap:Ethernet  HWaddr 00:04:76:F7:E9:17  
          inet addr:192.168.1.1  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST MULTICAST  MTU:1500  Metric:1

I do not understand why this does not work out just like another ptp-interface
like isdn:

isdn0     Link encap:Ethernet  HWaddr FC:FC:00:00:00:00  
          inet addr:192.168.1.1  P-t-P:192.168.5.1  Mask:255.255.255.255
          UP POINTOPOINT RUNNING NOARP  MTU:1500  Metric:1

Is there anything I mis-understood or a good reason for not being able to make
eth pointopoint?

I have the feeling this question is pretty brain-dead, but anyway, maybe some
kind soul can drop a few words ...
-- 
Regards,
Stephan
