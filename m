Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264682AbUEPRvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264682AbUEPRvF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 13:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264701AbUEPRvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 13:51:05 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:29606 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264682AbUEPRuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 13:50:50 -0400
Subject: Re: [patch] kill off PC9800
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>, randy.dunlap@osdl.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 16 May 2004 12:50:37 -0500
Message-Id: <1084729840.10938.13.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Randy.Dunlap" <rddunlap@osdl.org> wrote:
    >
    >  PC9800 sub-arch is incomplete, hackish (at least in IDE), maintainers
    >  don't reply to emails and haven't touched it in awhile.
    
    And the hardware is obsolete, isn't it?  Does anyone know when they were
    last manufactured, and how popular they are?
    
Hey, just being obsolete is no grounds for eliminating a
subarchitecture...

However, I would have to say that being unmaintained is.  Because of the
penchant of x86 people to go "it compiles on my PC, ship it", the x86
subarchitectures are about the fastest bitrotting pieces of the kernel
there are.

Since mach-pc9800 cannot currently be compiled and there's no evidence
that it actually was, I'd remove it unless someone steps up quickly to
maintain it (and get it to the point where it's actually compileable).

James


