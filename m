Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268989AbUJTUYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268989AbUJTUYx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 16:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270546AbUJTUTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 16:19:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:5531 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270548AbUJTUTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 16:19:00 -0400
Date: Wed, 20 Oct 2004 13:22:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add key management syscalls to non-i386 archs
Message-Id: <20041020132247.5f2b40da.akpm@osdl.org>
In-Reply-To: <23586.1098301696@redhat.com>
References: <p73d5zdyyxc.fsf@verdi.suse.de>
	<3506.1098283455@redhat.com.suse.lists.linux.kernel>
	<23586.1098301696@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> > Hey, I already allocated 248 for setaltroot.

I wouldn't be in a rush to wire up sys_altroot() actually.
Unless some security issues are resolved it's going away again.
