Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUC2CrO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 21:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbUC2CrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 21:47:14 -0500
Received: from cobra.mywebworx.net ([69.61.24.4]:36544 "EHLO
	cobra.mywebworx.net") by vger.kernel.org with ESMTP id S262574AbUC2CrN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 21:47:13 -0500
Message-ID: <1080528430.40678e2e9eb3a@www.beonline.com.au>
Date: Mon, 29 Mar 2004 12:47:10 +1000
From: lml@beonline.com.au
To: linux-kernel@vger.kernel.org
Subject: Kernel / Userspace Data Transfer
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 203.103.132.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cobra.mywebworx.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [32001 32001] / [47 12]
X-AntiAbuse: Sender Address Domain - beonline.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a set of counters in a Kernel module that i want to export to a
userspace application. I originally decided to use a /proc entry and parse
the output whenever the userspace application needed this data, however,
i need more than the 4096 that is allowed in /proc and i'm not too keen
on parsing large chunks of text anyway.

What i would like to do is copy these slabs of text from the kernel to my
userspace application (whenever the application requests it). I've seen the
'copy_to_user' function and it looks usefull, but have no idea where to start
or how to use it :-/

Can someone provide and example or point me in the right direction? Or is there
a better place to ask this question?

Regards
-J
