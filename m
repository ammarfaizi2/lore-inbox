Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264655AbUGIJmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264655AbUGIJmd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 05:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUGIJmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 05:42:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:10906 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264655AbUGIJmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 05:42:22 -0400
Date: Fri, 9 Jul 2004 02:41:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stefano Rivoir <s.rivoir@gts.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm7
Message-Id: <20040709024112.7ef44d1d.akpm@osdl.org>
In-Reply-To: <40EE5418.2040000@gts.it>
References: <20040708235025.5f8436b7.akpm@osdl.org>
	<40EE5418.2040000@gts.it>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefano Rivoir <s.rivoir@gts.it> wrote:
>
>  Andrew Morton wrote:
> 
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm7/
> 
>  Still hangs on boot, like -mm5 did,
> 
>     1. just after the ide0 recognition, last lines are:
> 
>  hda: QSI CD-RW/DVD-ROM SBW-242, ATAPI CD/DVD-ROM drive
>  Using anticipatory io scheduler
>  ide0 at 0x1f0-0x1f7, 0x3f6 on irq14
> 
>     2. just after the ACPI processor module insert, last line is
> 
>  ACPI: Processor [CPU0] (supports C1, C2, C3, 8 throttling states)
> 
>  2.6.7-bk20 runs fine instead.

Does the `acpi=off' boot option help?

Could you please try reverting bk-acpi.patch?
