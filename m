Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbULVMvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbULVMvR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 07:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbULVMvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 07:51:17 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:31718 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261980AbULVMvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 07:51:15 -0500
Subject: Re: help on driver's nopage mmap method
From: Steven Rostedt <rostedt@goodmis.org>
To: John Wang <john_wang1969@yahoo.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041222052322.39048.qmail@web61205.mail.yahoo.com>
References: <20041222052322.39048.qmail@web61205.mail.yahoo.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 22 Dec 2004 07:51:11 -0500
Message-Id: <1103719871.18160.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-21 at 21:23 -0800, John Wang wrote:
> Hi, I have been struggling for a couple of days about
> a problem of using nopage method to mmap memory from
> driver to user application.
> 
> What I try to do is very simple - just to get the
> simplest case to work, but I always get some junk in
> user app (to be more specific, always 0xFF in the mmap
> the memory area). I don't know what is wrong here - it
> appears perfectly normal (compared to the examples in
> the book Linux Device Driver). The kernel is 2.4.2
> running on Intel x86 platform.
> 
> The program is very simple so I attached here (header
> includes are ignored here to shorten the length).
> Please CC me directly if anyone has answer since I am
> not subscribed to the mailing list. Thanks in advance.

I just tried your program on both 2.4.20 and 2.6.9 and it works fine.
Kernel 2.4.2 is very old, you might want to try a different kernel.

-- Steve


