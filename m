Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288452AbSANAd6>; Sun, 13 Jan 2002 19:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288447AbSANAdu>; Sun, 13 Jan 2002 19:33:50 -0500
Received: from [203.6.240.4] ([203.6.240.4]:41233 "HELO
	cbus613-server4.colorbus.com.au") by vger.kernel.org with SMTP
	id <S288449AbSANAdl>; Sun, 13 Jan 2002 19:33:41 -0500
Message-ID: <370747DEFD89D2119AFD00C0F017E66156A8AE@cbus613-server4.colorbus.com.au>
From: Robert Lowery <Robert.Lowery@colorbus.com.au>
To: linux-kernel@vger.kernel.org
Cc: andrea@suse.de
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Mon, 14 Jan 2002 11:33:18 +1100
X-Mailer: Internet Mail Service (5.5.2653.19)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I question this because it is too risky to apply. There is no way any 
>distribution or production system could ever consider applying the 
>preempt kernel and ship it in its next kernel update 2.4. You never know 
>if a driver will deadlock because it is doing a test and set bit busy 
>loop by hand instead of using spin_lock and you cannot audit all the 
>device drivers out there.

Quick question from a kernel newbie.

Could this audit be partially automated by the Stanford Checker? or would
there
be too many false positives from other similar looping code?

-Robert
