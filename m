Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbUEZX1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUEZX1u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 19:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUEZX1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 19:27:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:32149 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261186AbUEZX1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 19:27:49 -0400
Date: Wed, 26 May 2004 16:30:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: mbligh@aracnet.com, linux-kernel@vger.kernel.org,
       Stephane LOEUILLET <bug-kernel@leroutier.net>
Subject: Re: [Bug 2773] New: kernel panic under medium load
Message-Id: <20040526163029.10b5c88c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405260918161.1770@ppc970.osdl.org>
References: <390810000.1085582148@[10.10.2.4]>
	<Pine.LNX.4.58.0405260918161.1770@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> What happens for you before? Can you do a "make mm/page_alloc.s" and post 
> the result (well, just __alloc_pages, not the rest).
> 

Stephane had added page_alloc.s to

	http://bugme.osdl.org/show_bug.cgi?id=2773

