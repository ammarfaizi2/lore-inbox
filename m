Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267809AbUHPRUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267809AbUHPRUx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 13:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267813AbUHPRUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 13:20:52 -0400
Received: from fire.osdl.org ([65.172.181.4]:63159 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S267809AbUHPRUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 13:20:50 -0400
Subject: 4 New compile/sparse warnings (2.6.8.1 - 2004-08-14.21.30)
From: John Cherry <cherry@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1092676650.19894.89.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 16 Aug 2004 10:17:30 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of new sparse warnings and compiler warnings in the nightly
builds (linus' bk tree)....

-----Forwarded Message-----
> From: John Cherry <cherry@osdl.org>
> To: cherry@osdl.org
> Subject: 4 New compile/sparse warnings (2.6.8.1 - 2004-08-14.21.30)
> Date: Sun, 15 Aug 2004 07:27:03 -0700
> 
> Compiler: gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)
> Arch: i386
> 
> 
> Summary:
>    New warnings = 4
>    Fixed warnings = 0
> 
> New warnings:
> -------------
> drivers/char/ipmi/ipmi_si_intf.c:1172:8: warning: incorrect type in argument 4 (different types)
> drivers/char/ipmi/ipmi_si_intf.c:1172:8:    expected unsigned int [usertype] ( *[usertype] address )( ... )
> drivers/char/ipmi/ipmi_si_intf.c:1172:8:    got void ( extern [addressable] [toplevel] *<noident> )( ... )
> 
> drivers/char/ipmi/ipmi_si_intf.c:1173: warning: passing arg 4 of `acpi_install_gpe_handler' from incompatible pointer type
> 
> drivers/char/ipmi/ipmi_si_intf.c:1193:43: warning: incorrect type in argument 3 (different types)
> drivers/char/ipmi/ipmi_si_intf.c:1193:43:    expected unsigned int [usertype] ( *[usertype] address )( ... )
> drivers/char/ipmi/ipmi_si_intf.c:1193:43:    got void ( extern [addressable] [toplevel] *<noident> )( ... )
> drivers/char/ipmi/ipmi_si_intf.c:1193: warning: passing arg 3 of `acpi_remove_gpe_handler' from incompatible pointer type
> 
> 
> Fixed warnings:
> ---------------

