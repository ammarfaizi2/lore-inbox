Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265141AbUHHFVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbUHHFVY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 01:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUHHFVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 01:21:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:47832 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265141AbUHHFVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 01:21:23 -0400
Date: Sat, 7 Aug 2004 22:21:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH][2.6] Completely out of line spinlocks / i386
In-Reply-To: <Pine.LNX.4.58.0408080110280.19619@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0408072220490.1793@ppc970.osdl.org>
References: <Pine.LNX.4.58.0408072123590.19619@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0408072157500.1793@ppc970.osdl.org>
 <Pine.LNX.4.58.0408080110280.19619@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 8 Aug 2004, Zwane Mwaikambo wrote:
> >
> > that looks just broken.
> 
> _raw_spin_lock will have the symbol __spin_lock_loop{,_flags} when used in
> symbols, modules won't load otherwise.

Yes, I was talking about the "failed" things only. The non-failure-cases 
obviously do have to be exported.

		Linus
