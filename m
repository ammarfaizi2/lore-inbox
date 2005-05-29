Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVE2Bcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVE2Bcz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 21:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVE2Bcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 21:32:55 -0400
Received: from dream.eng.uci.edu ([128.195.164.137]:26889 "EHLO
	dream.dream.eng.uci.edu") by vger.kernel.org with ESMTP
	id S261200AbVE2Bcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 21:32:53 -0400
From: "Liangchen Zheng" <zlc@dream.eng.uci.edu>
To: <linux-kernel@vger.kernel.org>
Subject: The values of gettimeofday() jumps.
Date: Sat, 28 May 2005 18:37:10 -0700
Message-ID: <000201c563ee$eed993d0$85a4c380@dream.eng.uci.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <20050528231737.805020000@nd47.coderock.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
X-OriginalArrivalTime: 29 May 2005 01:37:12.0609 (UTC) FILETIME=[EFC70110:01C563EE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
	We have several SMP machines (Tyan Tiger MPX motherboard, 2
AthlonMP 1900+ CPU, linux-2.4.21-20.EL).  When running some time
sensitive programs, I observed that the values of gettimeofday () jumped
sometimes on a couple of machines (other machines are fine), from
several hundreds milliseconds to a couple of seconds. 
	I searched online and tried to figure out why this happened. It
seems there are a lot of people who complained about the clock drift
issue of gettimeofday () on SMP machines. But I still could not get the
answers about what is the exact cause of this issue and how to fix it.
	Could somebody tell me some clues?  Can this be solved by
upgrading the kernel to 2.6? Thanks a lot.

By the way, I have read Linux SMP HOWTO and the following documents. 
http://seclists.org/lists/linux-kernel/2002/Jun/1524.html
http://seclists.org/lists/linux-kernel/2002/Jun/1550.html
http://alphalinux.org/archives/linux-alpha/April2000/0015.html
I could not get enough clues from them yet, maybe because my limited
knowledge about the kernel.

Regards,
[Liangchen Zheng] 
 

