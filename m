Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752500AbWAGCTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbWAGCTP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 21:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752511AbWAGCTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 21:19:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2698 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752500AbWAGCTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 21:19:13 -0500
Date: Fri, 6 Jan 2006 18:18:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/4] Consolidate asm/futex.h
Message-Id: <20060106181849.33a982f3.akpm@osdl.org>
In-Reply-To: <200601052253.k05MrngR010777@ccure.user-mode-linux.org>
References: <200601052253.k05MrngR010777@ccure.user-mode-linux.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> wrote:
>
> Most of the architectures have the same asm/futex.h.  This
>  consolidates them into asm-generic, with the arches including it
>  from their own asm/futex.h.
> 
>  In the case of UML, this reverts the old broken futex.h and goes back
>  to using the same one as almost everyone else.

I dropped the frv part - it's recently gone with a private version.
