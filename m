Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262507AbUKLKlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbUKLKlG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 05:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbUKLKlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 05:41:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:12938 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262507AbUKLKif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 05:38:35 -0500
Date: Fri, 12 Nov 2004 02:38:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
Subject: Re: [PATCH] VM routine fixes
Message-Id: <20041112023817.247af548.akpm@osdl.org>
In-Reply-To: <19844.1100255635@redhat.com>
References: <20041111143148.76dcaba4.akpm@osdl.org>
	<200411081432.iA8EWfmh023432@warthog.cambridge.redhat.com>
	<19844.1100255635@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> > > +#ifdef CONFIG_MMU
>  > >  	vma->vm_ops = &generic_file_vm_ops;
>  > > +#endif
>  > ...
>  > What's happening there?
> 
>  The vm_area_struct doesn't have an ops member when !MMU.

What is the reason for this change?
