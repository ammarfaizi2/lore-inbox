Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263375AbRFNQ6q>; Thu, 14 Jun 2001 12:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263378AbRFNQ6g>; Thu, 14 Jun 2001 12:58:36 -0400
Received: from zeus.kernel.org ([209.10.41.242]:15064 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S263375AbRFNQ62>;
	Thu, 14 Jun 2001 12:58:28 -0400
Message-Id: <200106141657.MAA09198@mailhost.eng.mc.xerox.com>
To: linux-kernel@vger.kernel.org
Subject: what's the purpose of SYMBOL_NAME()
Date: Thu, 14 Jun 2001 12:57:33 -0400
From: "Marty Leisner" <mleisner@eng.mc.xerox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I'm read Bovet's "Understand the Linux Kernel"
and looked at the assembly routine setup_idt...

I noticed the assembly has SYMBOL_NAME
(its all over the place).

This is define in include/linux/linkage.h

to just:
#define SYMBOL_NAME(X) X

(this wasn't in Bovet's book).

What's the purpose?  

marty		mleisner@eng.mc.xerox.com   
Don't  confuse education with schooling.
	Milton Friedman to Yogi Berra
