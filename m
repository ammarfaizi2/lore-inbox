Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbUAYBkg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 20:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbUAYBkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 20:40:35 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:42251 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S263388AbUAYBke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 20:40:34 -0500
Date: 25 Jan 2004 04:40:53 +0300
Message-Id: <87hdykerfe.fsf@mtu-net.ru>
From: Serge Belyshev <33554432@mtu-net.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-reply-to: <20040124101704.3bf3ada2.akpm@osdl.org> (message from Andrew
	Morton on Sat, 24 Jan 2004 10:17:04 -0800)
Subject: Re: [PATCH] arch/i386/Makefile,scripts/gcc-version.sh,Makefile small fixes
References: <87oestsard.fsf@mtu-net.ru> <20040124101704.3bf3ada2.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> *  Consider adding -fweb option:
>
>What does it do?

>From gcc(1):

       -fweb
           Constructs webs as commonly used for register allocation purposes and
           assign each web individual pseudo register.  This allows our register
           allocation pass to operate on pseudos directly, but also strengthens
           several other optimization passes, such as CSE, loop optimizer and
           trivial dead code remover.  It can, however, make debugging impossible,
           since variables will no longer stay in a ``home register''.

           Enabled at levels -O3.
