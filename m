Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268205AbRGWLn0>; Mon, 23 Jul 2001 07:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268204AbRGWLnQ>; Mon, 23 Jul 2001 07:43:16 -0400
Received: from wit.mht.bme.hu ([152.66.80.190]:55198 "HELO wit.wit.mht.bme.hu")
	by vger.kernel.org with SMTP id <S268205AbRGWLnC>;
	Mon, 23 Jul 2001 07:43:02 -0400
Date: Mon, 23 Jul 2001 13:43:01 +0200 (CEST)
From: Ferenc Kubinszky <ferenc.kubinszky@wit.mht.bme.hu>
To: linux-kernel@vger.kernel.org
Subject: Manipulating routing table
Message-ID: <Pine.LNX.4.02.10107231335010.8996-100000@wit.wit.mht.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

I'd like to access and modify the kernel routing table from a kernel
module. (v2.4.6)
The symbol ip_rt_ioctl is exported, but there is a copy_from_user(...)
call in fib_frontend.c line 302. I think it fails when I call it from
the module.

So, how can I modify the routing table from a module ?

Best regards,
Ferenc

