Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266591AbUHIOKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266591AbUHIOKh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266584AbUHIOJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:09:51 -0400
Received: from the-village.bc.nu ([81.2.110.252]:13001 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266591AbUHIOH5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:07:57 -0400
Subject: Re: Linux Kernel bug report (includes fix)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: vonbrand@inf.utfsm.cl, axboe@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200408091203.i79C3fYh009639@burner.fokus.fraunhofer.de>
References: <200408091203.i79C3fYh009639@burner.fokus.fraunhofer.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1092056719.14144.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 09 Aug 2004 14:05:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-09 at 13:03, Joerg Schilling wrote:
> >Jörg Schilling <schilling@fokus.fraunhofer.de> said:
> >> -	Linux Kernel include files (starting with Linux-2.5) are buggy and 
> >> 	prevent compilation.
> 
> >They do not, the kernel compiles just fine. They are _not_ to be used for
> >random userspace programs.
> 
> As you don't know how kernel/user interfaces are handled, it would be wise for 
> you to keep quiet.....

Linux kernel include files are not meant to be used by user
applications. He's perfectly correct. Glibc has its own exported set.
This is intentional to seperate internals from user space.

Alan

