Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267973AbUIJW6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267973AbUIJW6I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 18:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267968AbUIJW6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 18:58:08 -0400
Received: from the-village.bc.nu ([81.2.110.252]:28338 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267973AbUIJWuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 18:50:40 -0400
Subject: Re: `new' syscalls for m68k
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Debian GNU/Linux m68k <debian-68k@lists.debian.org>,
       uClinux list <uclinux-dev@uclinux.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409102250300.24607@anakin>
References: <Pine.LNX.4.58.0409102250300.24607@anakin>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094852893.18235.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Sep 2004 22:48:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-10 at 21:57, Geert Uytterhoeven wrote:
>   - Are sys_sched_[gs]etaffinity() needed for non-SMP?
Not really

>   - I disabled [sg]et_thread_area() since sys_[gs]et_thread_area() are
>     missing. Do we have to implement them, or should we use some other
>     method for Thread Local Storage?

Up to your implementation

>   - What about sys_vserver()?

Vserver project - probably dead for 2.6 since the SELinux and other
security modules can implement this same things (and a 2.6 vserver one
assumes would do likewise)

>   - What about sys_kexec_load()?

Depends if you support kexec


