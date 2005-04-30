Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVD3QrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVD3QrY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 12:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVD3QrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 12:47:23 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:18050 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S261289AbVD3QrG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 12:47:06 -0400
Subject: HyperThreading, kernel 2.6.10, 1 logical CPU idle !!
From: Boris Fersing <mastermac@free.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 30 Apr 2005 18:47:04 +0200
Message-Id: <1114879624.28579.6.camel@electron>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there, 

I've a p4 HT 3,06Ghz, I've HT enabled in the BIOS and in the kernel :

Linux electron 2.6.10-cj5 #6 SMP Fri Mar 4 02:18:08 CET 2005 i686 Mobile
Intel(R) Pentium(R) 4     CPU 3.06GHz GenuineIntel GNU/Linux .

But it seems that one of my cpus is idle (gkrellm monitor or top) :

Cpu0  : 88.0% us, 12.0% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,
0.0% si
Cpu1  :  0.0% us,  0.3% sy,  0.0% ni, 99.7% id,  0.0% wa,  0.0% hi,
0.0% si


I'm actually compiling thunderbird with MAKEOPTS="-j3", so , the second
should be used, shouldn't it ?

Is that a kernel issue ? Could you please explain me what's happening ?

Thank you !

Boris.

