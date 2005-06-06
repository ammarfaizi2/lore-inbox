Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVFFCg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVFFCg5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 22:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVFFCg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 22:36:57 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:27652 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261165AbVFFCgz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 22:36:55 -0400
Date: Sun, 5 Jun 2005 22:31:45 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Vishal Patil <vishpat@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory problems in schedule()
Message-ID: <20050606023145.GB11352@ccure.user-mode-linux.org>
References: <4745278c050605180115a70b8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4745278c050605180115a70b8d@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2005 at 09:01:19PM -0400, Vishal Patil wrote:
> 1) Whenever I select a process to run using my algorithm the kernel
> panics with "Segfault with no mm" basically the "mm" field of the
> task_struct that I selected is empty. I don't understand why this
> should happen, since I have just added code to select a process and
> haven't modified any memory related code in the schedule() function.

Start with a backtrace from the panic and debug it from there.

> 2) I am able to run the UMLfied kernel under gdb, however the execution
> never halts even though I set several breakpoints. Also these
> breakpoints have not been set in interrupt handling code and I have
> compiled the code with -g option.

UML and gdb versions?  tt or skas mode?

				Jeff
