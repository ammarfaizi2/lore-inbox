Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263836AbTLQJDd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 04:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbTLQJDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 04:03:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:49340 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263836AbTLQJDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 04:03:31 -0500
Date: Wed, 17 Dec 2003 01:03:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: "srikrish" <srikrish@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, anton@samba.org
Subject: Re: [PATCH] binfmt_elf.c SIGILL with large external static array on
 PPC64
Message-Id: <20031217010353.1fd32589.akpm@osdl.org>
In-Reply-To: <004101c3c47c$114a32d0$0d0fb609@srikrishnan>
References: <004101c3c47c$114a32d0$0d0fb609@srikrishnan>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"srikrish" <srikrish@in.ibm.com> wrote:
>
>  When using the follow code compiled as an ELF32 binary on a PPC64 machine, application terminates with a SIGILL.

Yes.  I have queued up a patch for this from Roland Turner.  It is at

	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test10/2.6.0-test10-mm1/broken-out/fix-ELF-exec-with-huge-bss.patch

Could you please review and test it?



