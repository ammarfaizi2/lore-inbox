Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264391AbUBKOIN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 09:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264433AbUBKOIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 09:08:12 -0500
Received: from sea2-f29.sea2.hotmail.com ([207.68.165.29]:5394 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264391AbUBKOIJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 09:08:09 -0500
X-Originating-IP: [212.143.127.195]
X-Originating-Email: [zstingx@hotmail.com]
From: "sting sting" <zstingx@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re : Re: printk and long long
Date: Wed, 11 Feb 2004 16:08:08 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F294mt5UJoched000331f3@hotmail.com>
X-OriginalArrivalTime: 11 Feb 2004 14:08:08.0505 (UTC) FILETIME=[79CB6290:01C3F0A8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Thnks

>printk("%ld%ld",loff_t >> (sizeof(long) * 8), loff_t << sizeof(long) * 8 >>
>sizeof(long) * 8);

Well I had tried it but I got
the follwing compilation errors while trying to add that code:
invalid operands to binary >>
invalid operands to binary <<

I assume maybe it is a problems with the flags I use:
I use gcc 3.2.2 and the flags are:
O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-DMODULE -D__KERNEL__ -DNOKERNEL

regards,
sting

_________________________________________________________________
The new MSN 8: smart spam protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail

