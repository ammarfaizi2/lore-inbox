Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265756AbUBJHxD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 02:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265763AbUBJHxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 02:53:03 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:57782 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265756AbUBJHxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 02:53:01 -0500
Date: Tue, 10 Feb 2004 16:52:20 +0900 (JST)
From: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Subject: Re: [PATCH] packet_sendmsg_spkt incorrectly truncates an interface name
In-reply-to: <20040209234341.0075159b.akpm@osdl.org>
To: akpm@osdl.org
Cc: maeda.naoaki@jp.fujitsu.com, linux-kernel@vger.kernel.org
Message-id: <20040210.165220.85391060.maeda@jp.fujitsu.com>
MIME-version: 1.0
X-Mailer: Mew version 2.2 on Emacs 20.3 / Mule 4.0 (HANANOEN)
Content-type: Text/Plain; charset=us-ascii
Content-transfer-encoding: 7bit
References: <20040210.163023.112606425.maeda@jp.fujitsu.com>
 <20040209234341.0075159b.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > Obviously, max name length of a network interface name is IFNAMESIZ-1, 
> > which is 15.
> 
> Yes, but sockaddr_pkt.spkt_device[] is only 14 bytes for some reason.

Oops! I have not checked it.
Does anybody know the reason why it is only 14 bytes?

Thanks,
Naoaki
