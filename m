Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265264AbUEUX5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbUEUX5w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265261AbUEUXv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:51:58 -0400
Received: from zeus.kernel.org ([204.152.189.113]:8380 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264692AbUEUXaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:30:15 -0400
Date: Wed, 19 May 2004 23:26:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: make fbmem.c:sys_{in,out}buf() static
Message-Id: <20040519232653.56ed1ef0.akpm@osdl.org>
In-Reply-To: <200405200621.i4K6LUfO003870@napali.hpl.hp.com>
References: <200405200621.i4K6LUfO003870@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger <davidm@napali.hpl.hp.com> wrote:
>
>  As far as I can tell, sys_inbuf() and sys_outbuf() aren't used
>  anywhere outside of fbmem.c, so make them static.

I'll rename them as well, get them out of the syscall namespace.
