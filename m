Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266090AbUBCUhn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 15:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUBCUhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 15:37:43 -0500
Received: from chaos.analogic.com ([204.178.40.224]:48003 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266090AbUBCUhk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 15:37:40 -0500
Date: Tue, 3 Feb 2004 15:40:28 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Matt Mackall <mpm@selenic.com>
cc: Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add syscalls.h
In-Reply-To: <20040203202916.GC31138@waste.org>
Message-ID: <Pine.LNX.4.53.0402031539250.32547@chaos>
References: <20040130163547.2285457b.rddunlap@osdl.org>
 <20040201222254.39bc5b39.rddunlap@osdl.org> <20040201224344.43d1c37d.akpm@osdl.org>
 <20040203202916.GC31138@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Feb 2004, Matt Mackall wrote:

> On Sun, Feb 01, 2004 at 10:43:44PM -0800, Andrew Morton wrote:
> > +extern asmlinkage long sys_unlink(const char __user *pathname);
> > +extern asmlinkage long sys_chmod(const char __user *filename, mode_t mode);
> > +extern asmlinkage long sys_fchmod(unsigned int fd, mode_t mode);
> >
> > Maybe lose the `extern' too.  It's just a waste of space.  I normally put
> > it in for consistency if the surrounding code is done that way, but for a
> > new header file, why bother?
>
> I'd really like to see the extern go, if only to discourage that
> particular bit of cargo cult programming. There are actually people
> who think it serves a purpose..
>
> --
> Matt Mackall : http://www.selenic.com : Linux development and consulting

THey got 'em advertised on eBay for $10.99  ;^


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


