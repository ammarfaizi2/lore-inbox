Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbVIWEts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbVIWEts (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 00:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbVIWEts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 00:49:48 -0400
Received: from xenotime.net ([66.160.160.81]:63707 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751289AbVIWEts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 00:49:48 -0400
Date: Thu, 22 Sep 2005 21:49:40 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Kumar Gala <kumar.gala@freescale.com>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: kernel buildsystem error/warning?
Message-Id: <20050922214940.5ab30894.rdunlap@xenotime.net>
In-Reply-To: <CE56193B-A4BB-4557-87C0-BFCC6B9E7E5B@freescale.com>
References: <CE56193B-A4BB-4557-87C0-BFCC6B9E7E5B@freescale.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2005 08:45:35 -0500 Kumar Gala wrote:

> Sam,
> 
> I was wondering if anyone else is seeing the following error/warning  
> when building a recent kernel.  This error seems to have been  
> introduced between 2.6.13 and 2.6.14-rc1:
> 
>    CHK     include/linux/version.h
>    CHK     include/linux/compile.h
>    CHK     usr/initramfs_list
> /bin/sh: line 1: +@: command not found
>    CHK     include/linux/compile.h
>    UPD     include/linux/compile.h
>    CC      init/version.o
>    LD      init/built-in.o
>    LD      vmlinux
>    SYSMAP  System.map
> 
> 
> I'm building a cross compiled ARCH ppc kernel on an x86 host.  I  
> tried using git bisect to track down the error but for some reason it  
> ended up referencing a change before 2.6.13 which I really dont  
> understand.
> 
> Anyways, let me know if you need more info on this.

I don't see the error message.  Do you have anything (added) to
usr/initramfs_list ?  (of course, the error messsage doesn't have
to be coming from that file at all)

---
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
