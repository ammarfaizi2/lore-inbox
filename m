Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263804AbUFKKtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263804AbUFKKtF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 06:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUFKKtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 06:49:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:44426 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263804AbUFKKtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 06:49:02 -0400
Date: Fri, 11 Jun 2004 03:48:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Permit inode & dentry hash tables to be allocated >
 MAX_ORDER size
Message-Id: <20040611034809.41dc9205.akpm@osdl.org>
In-Reply-To: <567.1086950642@redhat.com>
References: <567.1086950642@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
>  Here's a patch to allocate memory for big system hash tables with the bootmem
>  allocator rather than with main page allocator.

umm, why?
