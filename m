Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbVLJIPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbVLJIPO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 03:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbVLJIPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 03:15:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54168 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964960AbVLJIPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 03:15:12 -0500
Date: Sat, 10 Dec 2005 00:14:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: linux-kernel@vger.kernel.org, ananth@in.ibm.com, prasanna@in.ibm.com
Subject: Re: [BUG][PATCH] Kprobes - Increment kprobe missed count for
 multiprobes
Message-Id: <20051210001449.29d1ce4c.akpm@osdl.org>
In-Reply-To: <20051209130345.A8254@unix-os.sc.intel.com>
References: <20051209130345.A8254@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com> wrote:
>
>  +void __kprobes inc_nmissed_count(struct kprobe *p)

That's not a good name for a global identifier.  I renamed it to
kprobes_inc_nmissed_count().
