Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbTLWCie (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 21:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264433AbTLWCie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 21:38:34 -0500
Received: from dp.samba.org ([66.70.73.150]:65003 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264398AbTLWCid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 21:38:33 -0500
Date: Tue, 23 Dec 2003 13:25:28 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: admin@zionsecure.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.0 debian "No module symbols loaded - kernel modules
 not enabled."
Message-Id: <20031223132528.0dc06a0c.rusty@rustcorp.com.au>
In-Reply-To: <1072070706.2273.5.camel@noc.zionsecure.com>
References: <1072070706.2273.5.camel@noc.zionsecure.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Dec 2003 00:25:07 -0500
Brian Toovey <admin@zionsecure.com> wrote:

> Basic problem - my kernel modules wont load on boot.

This doesn't seem to be a kernel issue.

> Dec 21 18:33:54 noc kernel: Symbols match kernel version 2.6.0.
> Dec 21 18:33:54 noc kernel: No module symbols loaded - kernel modules
> not enabled. 

This is output from klogd.  Since you have CONFIG_KALLSYMS enabled, you
shouldn't need this anyway.

Cheers,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
