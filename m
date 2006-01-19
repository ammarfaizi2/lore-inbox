Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161308AbWASEh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161308AbWASEh4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 23:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161309AbWASEh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 23:37:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61625 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161308AbWASEhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 23:37:55 -0500
Date: Wed, 18 Jan 2006 20:37:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] prototypes for *at functions & typo fix
Message-Id: <20060118203733.5aac5ee4.akpm@osdl.org>
In-Reply-To: <200601190429.k0J4TWXD018136@devserv.devel.redhat.com>
References: <200601190429.k0J4TWXD018136@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper <drepper@redhat.com> wrote:
>
> Do we really need the __NR_ia32_* macros?  The userlevel on x86-64 should be bi-arch and provide the native ia32 unistd.h.

I'd have thought that x86 and x86_64 could source-level-share the syscall
table, yes.  ppc manages to.
