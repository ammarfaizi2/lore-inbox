Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbVJDC1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbVJDC1b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 22:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbVJDC1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 22:27:31 -0400
Received: from xenotime.net ([66.160.160.81]:19139 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932289AbVJDC1a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 22:27:30 -0400
Date: Mon, 3 Oct 2005 19:27:28 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Felix Oxley <lkml@oxley.org>
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: make xconfig fails for older kernels
Message-Id: <20051003192728.5f0c11c7.rdunlap@xenotime.net>
In-Reply-To: <200510040213.05361.lkml@oxley.org>
References: <200510040213.05361.lkml@oxley.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Oct 2005 02:13:03 +0100 Felix Oxley wrote:

> 
> I have downloaded 2.6.0 + patches up to 2.6.13 from kernel.org.
> 
> When I try to configure the kernel using 'make xconfig' I get the following 
> error:
> 
> scripts/kconfig/mconf.c:91: error: static declaration of ___current_menu___ 
> follows non-static declaration
> scripts/kconfig/lkc.h:63: error: previous declaration of ___current_menu___ was 
> here
> make[1]: *** [scripts/kconfig/mconf.o] Error 1
> make: *** [xconfig] Error 2
> 
> I attempted make menuconfig, make config, and make oldconfig but each failed 
> with the same error,
> 
> This happens on 2.6.0, 2.6.1, 2.6.2 2.6.3, 2.6.4.
> I have previously built newer kernels such as 2.6.13-rc2-rt7 without a 
> problem.
> 
> I was able to overcome the error by commenting out the declaration of 
> current_menu in mconf.c. But I am concerned as to the cause of this problem.
> 
> Does anyone have an explanation?

Sorry, not really, other than to say that make menuconfig and
make xconfig work fine for me on 2.6.4.
I just downloaded the 2.6.4 tarball and tested/verified them.

---
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
