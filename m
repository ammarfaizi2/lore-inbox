Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVEUQEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVEUQEv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 12:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVEUQEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 12:04:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35214 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261742AbVEUQEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 12:04:41 -0400
Date: Sat, 21 May 2005 17:05:08 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: latest sparse warnings with latest kernel
Message-ID: <20050521160508.GT29811@parcelfarce.linux.theplanet.co.uk>
References: <20050521143428.A25980@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050521143428.A25980@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2005 at 02:34:28PM +0100, Russell King wrote:
> Hi,
> 
> I'm seeing a lot of the following warnings when building the latest
> -git kernel with the latest sparse checker:
> 
> /usr/local/lib/gcc-lib/arm-linux/3.3/include/stdarg.h:54:9: warning: preprocessor token va_copy redefined
> /home/rmk/git/linux-2.6-rmk/include/linux/compiler-gcc2.h:29:9: this was the original definition
> 
> Since sparse pretends to be a gcc 2.95 compiler, should it really
> be using the gcc 3.3 header files?

Yes, but it should pretend to be 3.x.  See tarball on parcelfarce; I'll
send the patches to Linus.

> Shouldn't it provide its own headers to correspond with the version
> it pretends to be? 8)

No.
