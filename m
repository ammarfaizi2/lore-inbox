Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285829AbSA2XBN>; Tue, 29 Jan 2002 18:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285935AbSA2XA6>; Tue, 29 Jan 2002 18:00:58 -0500
Received: from www.transvirtual.com ([206.14.214.140]:38158 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S285692AbSA2XAF>; Tue, 29 Jan 2002 18:00:05 -0500
Date: Tue, 29 Jan 2002 14:59:36 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Daniel Jacobowitz <dan@debian.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <andrea@suse.de>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH?] Crash in 2.4.17/ptrace
In-Reply-To: <3C55CCE0.30189523@zip.com.au>
Message-ID: <Pine.LNX.4.10.10201291453250.29648-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It marks all framebuffer mappings as VM_IO.  This prevents
> kernel deadlocks which can occur when a program which
> has a framebuffer mapping attempts to dump core.

Good this is needed.

> I've Cc'ed linux-fbdev-devel.  Could someone please
> review?

> --- linux-2.4.18-pre7/drivers/video/acornfb.c	Thu Nov 22 23:02:58 2001

You missed the atyfb driver. Other then that it looks fine. Geert what do
you think? 


