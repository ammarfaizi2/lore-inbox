Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264352AbUFKWBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264352AbUFKWBr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 18:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbUFKWBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 18:01:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:51105 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264352AbUFKWBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 18:01:40 -0400
Date: Fri, 11 Jun 2004 15:04:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Permit inode & dentry hash tables to be allocated >
 MAX_ORDER size
Message-Id: <20040611150419.11281555.akpm@osdl.org>
In-Reply-To: <1056.1086952350@redhat.com>
References: <20040611034809.41dc9205.akpm@osdl.org>
	<567.1086950642@redhat.com>
	<1056.1086952350@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
>  (2) Changing MAX_ORDER appears to have a number of effects beyond just
>      limiting the maximum size that can be allocated in one go.

Several architectures implement CONFIG_FORCE_MAX_ZONEORDER and I haven't
heard of larger MAX_ORDERs causing problems.

Certainly, increasing MAX_ORDER is the simplest solution to the problems
which you identify so we need to substantiate these "number of effects"
much more than this please.
