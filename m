Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752301AbWAGPNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301AbWAGPNK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 10:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbWAGPNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 10:13:09 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:27040 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1752258AbWAGPNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 10:13:08 -0500
Date: Sat, 7 Jan 2006 16:12:50 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jeff Dike <jdike@addtoit.com>
cc: Rob Landley <rob@landley.net>, user-mode-linux-devel@lists.sourceforge.net,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: [PATCH 4/9] UML - Better diagnostics for broken
 configs
In-Reply-To: <20060107023713.GA13285@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.61.0601071612030.3578@yvahk01.tjqt.qr>
References: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org>
 <20060105161436.GA4426@ccure.user-mode-linux.org>
 <Pine.LNX.4.61.0601052258350.27662@yvahk01.tjqt.qr> <200601061801.17497.rob@landley.net>
 <20060107023713.GA13285@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Doing both of these things (a seperate host process for each UML process, and
>> calling getpid() for all system calls), is what "Tracing Thread" mode did.  
>> The UML kernel was one thread among several, and it was kinda slow.
>
>The skas vs tt distinction is the address space part of this.  How we nullify
>system calls is separate.  That's the PTRACE_SYSCALL vs PTRACE_SYSEMU (which
>is now in mainline) thing.
>

...
So there is no way to get UML compile on non-Linux.


Jan Engelhardt
-- 
