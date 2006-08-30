Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWH3BEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWH3BEo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 21:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWH3BEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 21:04:44 -0400
Received: from mailhub1.otago.ac.nz ([139.80.64.218]:21926 "EHLO
	mailhub1.otago.ac.nz") by vger.kernel.org with ESMTP
	id S1750892AbWH3BEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 21:04:43 -0400
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Transfer-Encoding: 7bit
Message-Id: <BD2148DD-779B-45BA-9C3B-8195245998EB@cs.otago.ac.nz>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linux-kernel@vger.kernel.org
From: zhiyi huang <hzy@cs.otago.ac.nz>
Subject: siginfo of SIGSEGV on UltraSPARC T1
Date: Wed, 30 Aug 2006 13:04:39 +1200
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,
Could anyone give me some information on how SIGSEGV is handled when  
a signal handler is installed. I need information about fault address  
and access type (read/write). I used the siginfo_t defined in bits/ 
siginfo.h, but the information I got from the handler arguments are  
not correct. Can anyone point out the right structure for the  
arguments of the signal handler.
I am using a Ubuntu port on Ultra Sparc T1, by the way.
Linux version 2.6.15-21-sparc64-smp (buildd@artigas) (gcc version  
4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #1 SMP Fri Apr 21 17:04:05 UTC 2006

Thanks:)
Zhiyi

