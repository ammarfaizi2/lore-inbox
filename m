Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUASNpY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 08:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264942AbUASNpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 08:45:24 -0500
Received: from chaos.analogic.com ([204.178.40.224]:52613 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264919AbUASNpS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 08:45:18 -0500
Date: Mon, 19 Jan 2004 08:46:54 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Bart Samwel <bart@samwel.tk>
cc: Ashish sddf <buff_boulder@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ kernel module + Makefile
In-Reply-To: <200401171359.20381.bart@samwel.tk>
Message-ID: <Pine.LNX.4.53.0401190839310.6496@chaos>
References: <20040116210924.61545.qmail@web12008.mail.yahoo.com>
 <Pine.LNX.4.53.0401161659470.31455@chaos> <200401171359.20381.bart@samwel.tk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jan 2004, Bart Samwel wrote:

> On Friday 16 January 2004 23:07, Richard B. Johnson wrote:
> > If somebody actually got a module, written in C++, to compile and
> > work on linux-2.4.nn, as you state, it works only by fiat, i.e., was
> > declared to work. There is no C++ runtime support in the kernel for
> > C++. Are you sure this is a module and not an application? Many
> > network processes (daemons) are applications and they don't require
> > any knowledge of kernel internals except what's provided by the
> > normal C/C++ include-files.
>
> Rest assured, ;) this is definitely a module. It includes a kernel patch that
> makes it possible to include a lot of the kernel headers into C++, stuff like
> changing asm :: to asm : : (note the space, :: is an operator in C++) and
> renaming "struct namespace" to something containing less C++ keywords. The
> module also includes rudimentary C++ runtime support code, so that the C++
> code will run inside the kernel. I'm afraid that the task of compiling it for
> 2.6 is going to be pretty tough -- the kernel needs loads of patches to make
> it work within a C++ extern "C" clause, and it probably completely different
> patches from those needed by 2.4. Getting the build system to work is the
> least of the concerns.
>
> -- Bart
>

I can't imagine why anybody would even attempt to write a kernel
module in C++. Next thing it'll be Visual BASIC, then Java. The
kernel is written in C and assembly. The tools are provided. It
can only be arrogance because this whole C v.s. C++ thing was
hashed-over many times. Somebody apparently wrote something to
"prove" that it can be done. I'd suggest that you spend some
time converting it to C if you need that "module". The conversion
will surely take less time than going through the kernel headers
looking for "::".

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


