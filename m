Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261607AbSJUUJD>; Mon, 21 Oct 2002 16:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261609AbSJUUJC>; Mon, 21 Oct 2002 16:09:02 -0400
Received: from 2-136.ctame701-1.telepar.net.br ([200.193.160.136]:11939 "EHLO
	2-136.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261607AbSJUUJB>; Mon, 21 Oct 2002 16:09:01 -0400
Date: Mon, 21 Oct 2002 18:14:48 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: =?ISO-8859-1?Q?Henr=FD_=DE=F3r?= Baldursson <henry@f-prot.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: System call wrapping
In-Reply-To: <1035222121.1063.20.camel@pc177>
Message-ID: <Pine.LNX.4.44L.0210211812240.22993-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Oct 2002, Henrý Þór Baldursson wrote:

> Apparently, this is something you kernel hackers don't approve of, since
> you've recently removed EXPORT_SYMBOL(sys_call_table) from
> kernel/ksyms.c - so my question is whether there is some other preferred
> method for accomplishing this without forcing the user to patch and
> compile a new kernel.  Is there some API for wrapping system calls which
> I am unaware of, or are there plans to provide one?

Maybe you could use the Linux Security Module hooks for
open() and exec() to pass a request to your virus scan
software ?

Note that this kernel module needs to be GPL, due to the
fact that it's a derived work of the kernel itself. This
only applies to the kernel module that asks the virus
scanner to check the files for virusses, not necessarily
the virus scanner itself.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

