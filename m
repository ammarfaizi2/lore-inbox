Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbULaNDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbULaNDi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 08:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbULaNDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 08:03:38 -0500
Received: from smtp.intoto.com ([207.145.48.18]:7698 "HELO
	ip-207-145-48-18.sjc.megapath.net") by vger.kernel.org with SMTP
	id S262008AbULaNDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 08:03:35 -0500
Message-Id: <6.1.2.0.1.20041231184958.02767968@172.16.1.10>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.2.0
Date: Fri, 31 Dec 2004 18:51:18 +0530
To: linux-kernel@vger.kernel.org
From: Uma Mahesh <mahesh@intotoinc.com>
Subject: Multicast data packets forwarding in Linux kernel w.r.t. IGMP
  Proxy
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am trying to implement the IGMP Proxy software in Linux.

I have some basic doubt related to forwarding multicast data packets
in linux, w.r.t. IGMP Proxy.

Is it the IGMP Proxy or Linux kernel (on which multicast routing support
is enabled), which one forwards multicast data packets?

In other words, is it required IGMP Proxy to route multicast data packets
based on membership database it has?
OR
Is it required to add multicast routes into the kernel, like a multicast
router adds using socket option MRT_ADD_MFC, from user space?

Do we have any exported calls to add/delete multicast routes in the kernel?
Can any body help in this regard?

Thanks in Advance,
Mahesh.


