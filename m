Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbUCQUhj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 15:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUCQUhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 15:37:39 -0500
Received: from web60505.mail.yahoo.com ([216.109.116.126]:55742 "HELO
	web60505.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262053AbUCQUgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 15:36:03 -0500
Message-ID: <20040317203602.75866.qmail@web60505.mail.yahoo.com>
Date: Wed, 17 Mar 2004 12:36:02 -0800 (PST)
From: Carl Spalletta <ioanamitu@yahoo.com>
Subject: Re: 10MB buffer
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am running a SuSE 2.4.19 Kernel and have a requirement
> to allocate a 10MB buffer (page aligned).

I suppose you mean contiguous in physical memory?
And accessible from userspace?

> Is this possbile via alloc_bootmem_pages?

This may be impossbile [sic].
see www.csn.ul.ie/~mel/projects/vm/guide/html/understand/node37.html

also see LKML thread "Re: mapping physical memory":

"tell the kernel that you have 8MB *less* RAM than is actually present
using a "mem=" directive at boot, then grab that last piece of memory
by mmap'ing /dev/mem."

see utah-glx.sourceforge.net/memory-usage.html


__________________________________
Do you Yahoo!?
Yahoo! Mail - More reliable, more storage, less spam
http://mail.yahoo.com
