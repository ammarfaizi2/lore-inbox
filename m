Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbULEGEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbULEGEl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 01:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbULEGEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 01:04:41 -0500
Received: from pool-151-203-6-248.bos.east.verizon.net ([151.203.6.248]:15108
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S261259AbULEGEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 01:04:39 -0500
Message-Id: <200412050819.iB58Jlhj006511@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: jonathan@jonmasters.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: Re: [PATCH] UML - SYSEMU fixes 
In-Reply-To: Your message of "Sat, 04 Dec 2004 11:28:28 GMT."
             <35fb2e5904120403281a63eccd@mail.gmail.com> 
References: <200412032145.iB3LjQZW004710@ccure.user-mode-linux.org>  <35fb2e5904120403281a63eccd@mail.gmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 05 Dec 2004 03:19:47 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jonmasters@gmail.com said:
> That's great, but do any of these patches address various undefines in
> arch/um/kernel/process.c:check_sysemu when built without skas? 

Apparently they did.  I just checked with skas turned off and got a successful
build.

> Also, on 2.6.9, I get dud CFLAGS defined when CONFIG_PROF is set *and*
> CONFIG_FRAME_POINTER is also set - gcc complains about use of "-gp"
> and "-fomit-frame-pointer" but surely it should be building with frame
> pointers anyway if I've asked it to do so? 

I just checked with that config, and it builds fine.

				Jeff

