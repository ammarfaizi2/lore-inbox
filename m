Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTKCJ3M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 04:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbTKCJ3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 04:29:12 -0500
Received: from web40907.mail.yahoo.com ([66.218.78.204]:44102 "HELO
	web40907.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261827AbTKCJ3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 04:29:10 -0500
Message-ID: <20031103092909.4955.qmail@web40907.mail.yahoo.com>
Date: Mon, 3 Nov 2003 01:29:09 -0800 (PST)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: What do frame pointers do?
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031102204556.0c5b377a.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Dunlap,

--- "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> On Sun, 2 Nov 2003 09:00:29 -0800 (PST) Bradley Chapman <kakadu_croc@yahoo.com>
> wrote:
> 
> | What exactly is the purpose of a frame pointer? As far back as I can remember,
> 2.4
> | and 2.6 kernels have supported something called a frame pointer, which slows
> down
> | the kernel slightly but supposedly outputs 'very useful debugging information.'
> | Unfortunately, it doesn't really explain what they are, and for the past few
> months,
> | I haven't seen any hacker gods asking for CONFIG_FRAME_POINTER=y, except for
> Russell
> | King, who wants them compiled for ARM processors for some reason (I grepped the
> | kernel source looking for answers and found a comment which implied this).
> | 
> | Does anyone know where I can find a good explanation of what they are and what
> they
> | do?
> 
> Frame pointers enable more deterministic back tracing of the stack,
> which can be helpful for tracking down bugs.  I build with
> CONFIG_FRAME_POINTER enabled all of the time.
> 
> Note, however, that current 2.6.x Makefile does not allow frame pointers
> to be used with gcc 2.96 since it has some known problems with code generation
> when using frame pointers.
> 
> There is a little discussion of frame pointers in the Intel
> IA-32 Intel® Architecture Software Developer;s Manual Volume 1:
> Basic Architecture
> and
> IA-32 Intel® Architecture Software Developer's Manual Volume 2:
> Instruction Set Reference,
> which are downloadable as .pdf files from developer.intel.com.

OK, thanks for explaining it to me.

> 
> --
> ~Randy

Brad


=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
Exclusive Video Premiere - Britney Spears
http://launch.yahoo.com/promos/britneyspears/
