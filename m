Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263883AbTLEF0z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 00:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263885AbTLEF0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 00:26:55 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:40770 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S263883AbTLEF0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 00:26:54 -0500
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: <Valdis.Kletnieks@vt.edu>, "'Peter Chubb'" <peter@chubb.wattle.id.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux GPL and binary module exception clause? 
Date: Thu, 4 Dec 2003 21:26:44 -0800
Organization: Cisco Systems
Message-ID: <00dc01c3baf0$6152a770$d43147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <200312050513.hB55D1ps030713@turing-police.cc.vt.edu>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here's the part where people's eyes glaze over:
> 
> % cd /usr/src/linux-2.6.0-test10-mm1
> % find include -name '*.h' | xargs egrep 'static.*inline' | wc -l
>    6288
> 
> That's 6,288 chances for you to #include GPL code and end up
> with executable derived from it in *your* .o file, not the kernel's.

What's so fundamentally different about inline functions, or, IOW, a
finer format of macros?

It doesn't matter if the API is inline or not. What matters is if using
this API makes your program a derivative work. From this perspective,
it's just an interface, no matter how it's implemented.

Let's be frank: how many people really try to read the header file when
they use these APIs? They don't care if they are inlined or not. To them
they are just _APIs_.




