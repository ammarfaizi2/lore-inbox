Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbUCJA7A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 19:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbUCJA7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 19:59:00 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:11727 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262459AbUCJA66 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 19:58:58 -0500
From: "Ingo at Pyrillion" <ingo@pyrillion.org>
To: "'Norihiko Mukouyama'" <norihiko_m@jp.fujitsu.com>,
       "'Norberto Bensa'" <norberto+linux-kernel@bensa.ath.cx>
Cc: <linux-kernel@vger.kernel.org>
Subject: AW: Kernel 2.6.3 patch for Intel Compiler 8.0
Date: Wed, 10 Mar 2004 01:58:51 +0100
Message-ID: <000201c4063a$db038f90$374ca8c0@bunnybook2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <FLEBKJHLJPMMOPBNJGELCEMMCNAA.norihiko_m@jp.fujitsu.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:c4c36d513a3e07b982252e2b8ea3678d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

please read my last mail carefully: 
"33% procs faster on icc, 66% faster on gcc"
means that gcc (GNU) is superior. But the patch is a preliminary 
version...

greetings, Ingo.

-----Ursprüngliche Nachricht-----
Von: Norihiko Mukouyama [mailto:norihiko_m@jp.fujitsu.com] 
Gesendet: Mittwoch, 10. März 2004 01:50
An: Ingo at Pyrillion; 'Norberto Bensa'
Cc: linux-kernel@vger.kernel.org
Betreff: RE: Kernel 2.6.3 patch for Intel Compiler 8.0


Hi All!!

>I used the patch to compile two identical kernels with gcc 3.3.3 and 
>icc 8.0 with oprofile support built in. The optimization switches were 
>chosen quite conservative, i.e. "-O2 -Ob1", no IPO, and of course: no 
>MMX, SSE, and SSE2 stuff inside the kernel (thus disabling Intel's 
>great vectorizer).
>Profiling: lmbench ran ten times but time measurements were taken from 
>oprofile (on Pentium 4, GLOBAL_POWER_EVENTS in kernel space only, 
>counter overflow: 3.000).
>Results: 33% of the lmbench procs faster on icc, 66% faster on gcc.

Really???

If it is ture using icc 66% faster than gcc., It is wonderful. 
Could you show us detail data to  lmbench results.

Thanks!!

Norihiko



