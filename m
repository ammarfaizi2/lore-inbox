Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263302AbUDEVmX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263291AbUDEVV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:21:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:13516 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263271AbUDEVTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:19:04 -0400
Date: Mon, 5 Apr 2004 14:21:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: trivial@rustcorp.com.au, akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: Cleanup & (partly?) support swsusp for aic7xxx
Message-Id: <20040405142113.1f845aba.akpm@osdl.org>
In-Reply-To: <20040405210346.GA3520@elf.ucw.cz>
References: <20040405210346.GA3520@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> This kills checks for kernels older than 2.5.60, and marks threads as
> needed for suspend (which they probably are).

This driver supports 2.4.x kernels from the same codebase, so this will be
an unpopular patch.

I'll move the PF_IOTHREAD inside the 2.6-specific leg of the ifdef.
