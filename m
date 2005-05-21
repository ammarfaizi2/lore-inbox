Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVEUNeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVEUNeq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 09:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVEUNeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 09:34:46 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:65042 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261420AbVEUNed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 09:34:33 -0400
Date: Sat, 21 May 2005 14:34:28 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: latest sparse warnings with latest kernel
Message-ID: <20050521143428.A25980@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing a lot of the following warnings when building the latest
-git kernel with the latest sparse checker:

/usr/local/lib/gcc-lib/arm-linux/3.3/include/stdarg.h:54:9: warning: preprocessor token va_copy redefined
/home/rmk/git/linux-2.6-rmk/include/linux/compiler-gcc2.h:29:9: this was the original definition

Since sparse pretends to be a gcc 2.95 compiler, should it really
be using the gcc 3.3 header files?

Shouldn't it provide its own headers to correspond with the version
it pretends to be? 8)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
