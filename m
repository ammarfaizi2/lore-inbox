Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbUAYBzF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 20:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263472AbUAYBzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 20:55:05 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:52754 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S263452AbUAYBzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 20:55:02 -0500
Date: 25 Jan 2004 04:55:23 +0300
Message-Id: <87fze4eqr8.fsf@mtu-net.ru>
From: Serge Belyshev <33554432@mtu-net.ru>
To: Valdis.Kletnieks@vt.edu
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <200401241832.i0OIWYl1030218@turing-police.cc.vt.edu>
	(Valdis.Kletnieks@vt.edu)
Subject: Re: [PATCH] arch/i386/Makefile,scripts/gcc-version.sh,Makefile small fixes
References: <87oestsard.fsf@mtu-net.ru>
            <20040124101704.3bf3ada2.akpm@osdl.org> <200401241832.i0OIWYl1030218@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Also, at least for the Fedora gcc-ssa compiler, -funit-at-a-time is *not* a
>default option (provably so - building with gcc-ssa makes a kernel that hangs
>*very* early on (right after 'decompressing the kernel' - I haven't dug into

But for gcc-3_4-branch (3.4.0 prerelease) and mainline (3.5.0 experimental)
-funit-at-a-time is default (at -O2 and higher) and works (at least for me :-).
