Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVCGLsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVCGLsc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 06:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVCGLsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 06:48:31 -0500
Received: from fire.osdl.org ([65.172.181.4]:11217 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261372AbVCGLs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 06:48:29 -0500
Date: Mon, 7 Mar 2005 03:47:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] BDI: Provide backing device capability information
Message-Id: <20050307034747.4c6e7277.akpm@osdl.org>
In-Reply-To: <9741.1110195784@redhat.com>
References: <20050307033734.5cc75183.akpm@osdl.org>
	<20050303123448.462c56cd.akpm@osdl.org>
	<20050302135146.2248c7e5.akpm@osdl.org>
	<20050302090734.5a9895a3.akpm@osdl.org>
	<9420.1109778627@redhat.com>
	<31789.1109799287@redhat.com>
	<13767.1109857095@redhat.com>
	<9268.1110194624@redhat.com>
	<9741.1110195784@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > >  So I should fold the two other bitfields back into the capabilities mask
> > >  and make it an unsigned long.
> > 
> > I suppose so.  Although unsigned int would be preferable.
> 
> Any particular reason? It's mixed in with other unsigned longs and pointers
> after all...

Just that it's the natural wordsize of the machine, and uses less storage.
