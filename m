Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWDYHtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWDYHtK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 03:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWDYHtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 03:49:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64213 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751402AbWDYHtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 03:49:09 -0400
Date: Tue, 25 Apr 2006 00:47:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: holzheu@de.ibm.com, ioe-lkml@rameria.de, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com, joern@wohnheim.fh-wedel.de
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
Message-Id: <20060425004736.451644bb.akpm@osdl.org>
In-Reply-To: <1145950336.11463.8.camel@localhost>
References: <20060424191941.7aa6412a.holzheu@de.ibm.com>
	<1145948304.11463.5.camel@localhost>
	<1145950336.11463.8.camel@localhost>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg <penberg@cs.helsinki.fi> wrote:
>
> +#ifndef __HAVE_ARCH_STRSTRIP
>  +extern char * strstrip(char *);
>  +#endif

Do we really need this gunk?  It's not as if strstrip() is so super
performance-sensitive that anyone would go and write a hand-tuned assembly
version?
