Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVCGLiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVCGLiR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 06:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVCGLiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 06:38:17 -0500
Received: from fire.osdl.org ([65.172.181.4]:40143 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261280AbVCGLiQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 06:38:16 -0500
Date: Mon, 7 Mar 2005 03:37:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] BDI: Provide backing device capability information
Message-Id: <20050307033734.5cc75183.akpm@osdl.org>
In-Reply-To: <9268.1110194624@redhat.com>
References: <20050303123448.462c56cd.akpm@osdl.org>
	<20050302135146.2248c7e5.akpm@osdl.org>
	<20050302090734.5a9895a3.akpm@osdl.org>
	<9420.1109778627@redhat.com>
	<31789.1109799287@redhat.com>
	<13767.1109857095@redhat.com>
	<9268.1110194624@redhat.com>
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
>  > >  Making these into bitfields would result in having to use three variables
>  > >  instead of just the one.
>  > 
>  > Well let's do one or the other, and not have it half-and-half, please.
> 
>  So I should fold the two other bitfields back into the capabilities mask and
>  make it an unsigned long.

I suppose so.  Although unsigned int would be preferable.
