Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbVAIEzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbVAIEzA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 23:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbVAIEzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 23:55:00 -0500
Received: from fsmlabs.com ([168.103.115.128]:62595 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262022AbVAIEy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 23:54:59 -0500
Date: Sat, 8 Jan 2005 21:55:12 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Boottime allocated GDTs and doublefault handler
In-Reply-To: <Pine.LNX.4.61.0412200806060.17024@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.61.0501082150370.13601@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0412191730330.18272@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0412191824280.4112@ppc970.osdl.org>
 <Pine.LNX.4.61.0412192307490.18310@montezuma.fsmlabs.com>
 <Pine.LNX.4.61.0412200806060.17024@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004, Zwane Mwaikambo wrote:

> On Mon, 20 Dec 2004, Zwane Mwaikambo wrote:
> 
> > Ok =), i've added the page table walker and some basic code to fish out 
> > 'current' and dump a few words of its stack. Sorry about the noise in the 
> > patch but the nested if()s were beginning to go too far.

Ok was this patch that offensive? ;) I've been trying to work in the task 
killing code, but it looks like there might be trickery required to switch 
back to the interrupted task.
