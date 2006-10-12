Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWJLWhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWJLWhi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 18:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWJLWhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 18:37:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57558 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751228AbWJLWhh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 18:37:37 -0400
Date: Thu, 12 Oct 2006 15:37:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Zach Brown <zach.brown@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] call truncate_inode_pages in the DIO fallback to
 buffered I/O path
Message-Id: <20061012153724.9805f458.akpm@osdl.org>
In-Reply-To: <x491wpdb3co.fsf@segfault.boston.devel.redhat.com>
References: <x49zmcc6mhh.fsf@segfault.boston.devel.redhat.com>
	<20061004102522.d58c00ef.akpm@osdl.org>
	<4523F486.1000604@oracle.com>
	<x49mz8c6k83.fsf@segfault.boston.devel.redhat.com>
	<20061004111603.20cdaa35.akpm@osdl.org>
	<45240034.2040704@oracle.com>
	<20061004121645.fd2765e4.akpm@osdl.org>
	<x49ejtn7qfy.fsf@segfault.boston.devel.redhat.com>
	<20061004165504.c1dd3dd3.akpm@osdl.org>
	<x49ac4a5zkw.fsf@segfault.boston.devel.redhat.com>
	<20061006131148.9c6b88ab.akpm@osdl.org>
	<m3odsi4x3a.fsf@redhat.com>
	<20061011113720.463e331c.akpm@osdl.org>
	<x491wpdb3co.fsf@segfault.boston.devel.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006 18:01:43 -0400
Jeff Moyer <jmoyer@redhat.com> wrote:

> This passes my tests and the Oracle tests that triggered the problem in the
> first place.  Thanks!
> 
> Acked-by: Jeff Moyer <jmoyer@redhat.com>

OK, thanks for testing.

We'll have added at least one bug.  We always do in there :(

I'll do some fsx-linux-with-O_DIRECT testing..
