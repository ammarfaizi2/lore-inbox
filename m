Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268409AbUGXKBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268409AbUGXKBD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 06:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268410AbUGXKBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 06:01:03 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:7445 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268409AbUGXKBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 06:01:01 -0400
Message-ID: <2de46576040724030153d7877@mail.gmail.com>
Date: Sat, 24 Jul 2004 15:31:01 +0530
From: Manjunath Prabhu <manjunath.mp@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: modify tcp header in the kernel
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
i am using the debian linux and am working on the 2.6.6 kernel.
i want to access the tcp header, modify it (by passing it through my
function) and then
put it back for the regular flow to continue.
can somebody tell me where i can access TCP header....
this is what i think should be done.

1.will using (struct sk_buff*)skb->h.th be sufficient
2.using hook to divert the regular flow.
3.passing it to my function.
4.putting it back.

am i right???
-best regards,
manjunath
