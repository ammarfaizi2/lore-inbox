Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbTIAAxE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 20:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262887AbTIAAxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 20:53:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:56468 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262799AbTIAAxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 20:53:01 -0400
Message-ID: <33327.4.4.25.4.1062377579.squirrel@www.osdl.org>
Date: Sun, 31 Aug 2003 17:52:59 -0700 (PDT)
Subject: Re: [PATCH] Add documentation for /proc/stat
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <bos@serpentine.com>
In-Reply-To: <1062307148.17532.17.camel@camp4.serpentine.com>
References: <1062307148.17532.17.camel@camp4.serpentine.com>
X-Priority: 3
Importance: Normal
Cc: <torvalds@osdl.org>, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> proc.txt |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++ 1
> files changed, 53 insertions(+)
>
>
> # 03/08/30	bos@camp4.serpentine.com	1.1292
> # Add documentation for /proc/stat.
> # This is based on reading of the code in fs/proc/proc_misc.c, so it
> # ought to be 100% accurate.
> #
> diff -Nru a/Documentation/filesystems/proc.txt
> b/Documentation/filesystems/proc.txt ---
> a/Documentation/filesystems/proc.txt	Sat Aug 30 22:11:50 2003
> +++ b/Documentation/filesystems/proc.txt	Sat Aug 30 22:11:50 2003

> +The "intr" line gives counts of interrupts  serviced since boot time, for
> each +of the  possible system interrupts.   The first  column  is the  total
> of  all +interrupts serviced; each  subsequent column is the  total for that
> particular +interrupt.

(stoopid webmail client mangles text above)

The "intr" line is omitted for PPC64 and ALPHA.
[#if !defined(CONFIG_PPC64) && !defined(CONFIG_ALPHA)]

~Randy



