Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbUEJVz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUEJVz1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 17:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbUEJVz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 17:55:27 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:34832 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261943AbUEJVzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 17:55:20 -0400
Date: Mon, 10 May 2004 22:55:15 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Jon Smirl <jonsmirl@yahoo.com>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <keithp@keithp.com>
Subject: Re: Is it possible to implement interrupt time printk's reliably?
In-Reply-To: <20040509163310.46944.qmail@web14923.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0405102253330.8016-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So how do printk's work in the very early boot? Is the video card active before
> the kernel probes it's module, or are these very early printk's being queued
> until the video driver is probed?

printk messages are stored in log_buf in printk.c. The console driver just 
reads the buffer and displays what is in the buffer. Look at printk.c 
carefully.

 

