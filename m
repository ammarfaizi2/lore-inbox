Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317723AbSGPBIQ>; Mon, 15 Jul 2002 21:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317721AbSGPBIP>; Mon, 15 Jul 2002 21:08:15 -0400
Received: from [210.78.134.243] ([210.78.134.243]:30993 "EHLO 210.78.134.243")
	by vger.kernel.org with ESMTP id <S317722AbSGPBIN>;
	Mon, 15 Jul 2002 21:08:13 -0400
Date: Tue, 16 Jul 2002 9:13:19 +0800
From: zhengchuanbo <zhengcb@netpower.com.cn>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: how to improve the throughput of linux network
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <200207160915391.SM00792@zhengcb>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


we use linux as our router. i just tested the performance of the router with smartbits, and i found that the throughput of 64byte frame is only 25%, about 35kpps. 
someone mentioned that the throughput of 64byte frame could reach 70kpps.so i wish i could improve the performance of our router,but i don't know how to do that.
i looked for some solution,and found some article mentioned the NAPI. it changed the driver to polling mode,so that the interrupt is no too much. but i could not find  drivers for our router.(eepro100 card). has the polling mode driver been used in linux?
i think there should be some other methods to improve the performance.but what is the most efficient one?
thanks for help. please cc.

chuanbo zheng

