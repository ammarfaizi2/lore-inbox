Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUJAQqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUJAQqA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 12:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbUJAQp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 12:45:59 -0400
Received: from fire.osdl.org ([65.172.181.4]:21385 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S264500AbUJAQpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 12:45:49 -0400
Subject: 35 New compile/sparse warnings (overnight run)
From: John Cherry <cherry@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1096649099.3352.5.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 01 Oct 2004 09:45:00 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I realize this may represent warnings that have "moved" in the code, but
there are new warnings in...

        drivers/char/cyclades.c and 
        drivers/net/wan/pc300_tty.c
	drivers/video/radeonfb.c

Note that a large number of warnings have been fixed (I didn't list all
of those).

John

-----------------------------------------------------------------------	

Compiler: gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)
Arch: i386


Summary:
   New warnings = 35
   Fixed warnings = 889

New warnings:
-------------
drivers/char/cyclades.c:2892:35: warning: incorrect type in argument 2
(different address spaces)
drivers/char/cyclades.c:2892:35:    expected void const [noderef]
*from<asn:1>
drivers/char/cyclades.c:2892:35:    got unsigned char const *buf

drivers/net/wan/pc300_tty.c:488:31: warning: incorrect type in argument
2 (different address spaces)
drivers/net/wan/pc300_tty.c:488:31:    expected void const [noderef]
*from<asn:1>
drivers/net/wan/pc300_tty.c:488:31:    got unsigned char const *buf

drivers/net/wan/pc300_tty.c:740:13: warning: cast removes address space
of expression

drivers/net/wan/pc300_tty.c:743:12: warning: incorrect type in argument
1 (different address spaces)
drivers/net/wan/pc300_tty.c:743:12:    expected void const volatile
[noderef] *addr<asn:2>
drivers/net/wan/pc300_tty.c:743:12:    got unsigned char volatile
[addressable] [usertype] *<noident>

drivers/net/wan/pc300_tty.c:744:3: warning: incorrect type in argument 2
(different address spaces)
drivers/net/wan/pc300_tty.c:744:3:    expected void volatile [noderef]
*addr<asn:2>
drivers/net/wan/pc300_tty.c:744:3:    got unsigned char volatile
[addressable] [usertype] *<noident>

drivers/net/wan/pc300_tty.c:745:3: warning: incorrect type in argument 2
(different address spaces)
drivers/net/wan/pc300_tty.c:745:3:    expected void volatile [noderef]
*addr<asn:2>
drivers/net/wan/pc300_tty.c:745:3:    got unsigned short volatile
[addressable] [usertype] *<noident>

drivers/net/wan/pc300_tty.c:751:14: warning: cast removes address space
of expression

drivers/net/wan/pc300_tty.c:751:47: warning: incorrect type in argument
1 (different address spaces)
drivers/net/wan/pc300_tty.c:751:47:    expected void const volatile
[noderef] *addr<asn:2>
drivers/net/wan/pc300_tty.c:751:47:    got unsigned long volatile
[addressable] [usertype] *<noident>

drivers/net/wan/pc300_tty.c:779:14: warning: cast removes address space
of expression

drivers/net/wan/pc300_tty.c:780:20: warning: incorrect type in argument
1 (different address spaces)
drivers/net/wan/pc300_tty.c:780:20:    expected void const volatile
[noderef] *addr<asn:2>
drivers/net/wan/pc300_tty.c:780:20:    got unsigned char volatile
[addressable] [usertype] *<noident>

drivers/net/wan/pc300_tty.c:781:14: warning: incorrect type in argument
1 (different address spaces)
drivers/net/wan/pc300_tty.c:781:14:    expected void const volatile
[noderef] *addr<asn:2>
drivers/net/wan/pc300_tty.c:781:14:    got unsigned short volatile
[addressable] [usertype] *<noident>

drivers/net/wan/pc300_tty.c:786:13: warning: cast removes address space
of expression

drivers/net/wan/pc300_tty.c:786:43: warning: incorrect type in argument
1 (different address spaces)
drivers/net/wan/pc300_tty.c:786:43:    expected void const volatile
[noderef] *addr<asn:2>
drivers/net/wan/pc300_tty.c:786:43:    got unsigned long volatile
[addressable] [usertype] *<noident>

drivers/net/wan/pc300_tty.c:818:14: warning: cast removes address space
of expression

drivers/net/wan/pc300_tty.c:823:20: warning: incorrect type in argument
1 (different address spaces)
drivers/net/wan/pc300_tty.c:823:20:    expected void const volatile
[noderef] *addr<asn:2>
drivers/net/wan/pc300_tty.c:823:20:    got unsigned char volatile
[addressable] [usertype] *<noident>

drivers/net/wan/pc300_tty.c:824:13: warning: incorrect type in argument
1 (different address spaces)
drivers/net/wan/pc300_tty.c:824:13:    expected void const volatile
[noderef] *addr<asn:2>
drivers/net/wan/pc300_tty.c:824:13:    got unsigned short volatile
[addressable] [usertype] *<noident>

drivers/net/wan/pc300_tty.c:862:7: warning: cast removes address space
of expression
drivers/net/wan/pc300_tty.c:862:7: warning: incorrect type in argument 2
(different address spaces)
drivers/net/wan/pc300_tty.c:862:7:    expected void volatile [noderef]
*src<asn:2>
drivers/net/wan/pc300_tty.c:862:7:    got void *<noident>

drivers/net/wan/pc300_tty.c:863:7: warning: incorrect type in argument 1
(different address spaces)
drivers/net/wan/pc300_tty.c:863:7:    expected void const volatile
[noderef] *addr<asn:2>
drivers/net/wan/pc300_tty.c:863:7:    got unsigned long volatile
[addressable] [usertype] *<noident>

drivers/net/wan/pc300_tty.c:866:4: warning: incorrect type in argument 2
(different address spaces)
drivers/net/wan/pc300_tty.c:866:4:    expected void volatile [noderef]
*addr<asn:2>
drivers/net/wan/pc300_tty.c:866:4:    got unsigned char volatile
[addressable] [usertype] *<noident>

drivers/net/wan/pc300_tty.c:867:4: warning: incorrect type in argument 2
(different address spaces)
drivers/net/wan/pc300_tty.c:867:4:    expected void volatile [noderef]
*addr<asn:2>
drivers/net/wan/pc300_tty.c:867:4:    got unsigned short volatile
[addressable] [usertype] *<noident>

drivers/net/wan/pc300_tty.c:872:15: warning: cast removes address space
of expression

drivers/net/wan/pc300_tty.c:873:6: warning: incorrect type in argument 1
(different address spaces)
drivers/net/wan/pc300_tty.c:873:6:    expected void const volatile
[noderef] *addr<asn:2>
drivers/net/wan/pc300_tty.c:873:6:    got unsigned long volatile
[addressable] [usertype] *<noident>

drivers/net/wan/pc300_tty.c:957:14: warning: cast removes address space
of expression

drivers/net/wan/pc300_tty.c:960:7: warning: incorrect type in argument 1
(different address spaces)
drivers/net/wan/pc300_tty.c:960:7:    expected void const volatile
[noderef] *addr<asn:2>
drivers/net/wan/pc300_tty.c:960:7:    got unsigned char volatile
[addressable] [usertype] *<noident>

drivers/net/wan/pc300_tty.c:961:17: warning: cast removes address space
of expression
drivers/net/wan/pc300_tty.c:961:17: warning: incorrect type in argument
1 (different address spaces)
drivers/net/wan/pc300_tty.c:961:17:    expected void volatile [noderef]
*dst<asn:2>
drivers/net/wan/pc300_tty.c:961:17:    got void *<noident>

drivers/net/wan/pc300_tty.c:962:5: warning: incorrect type in argument 1
(different address spaces)
drivers/net/wan/pc300_tty.c:962:5:    expected void const volatile
[noderef] *addr<asn:2>
drivers/net/wan/pc300_tty.c:962:5:    got unsigned long volatile
[addressable] [usertype] *<noident>

drivers/net/wan/pc300_tty.c:968:5: warning: incorrect type in argument 2
(different address spaces)
drivers/net/wan/pc300_tty.c:968:5:    expected void volatile [noderef]
*addr<asn:2>
drivers/net/wan/pc300_tty.c:968:5:    got unsigned char volatile
[addressable] [usertype] *<noident>

drivers/net/wan/pc300_tty.c:970:5: warning: incorrect type in argument 2
(different address spaces)
drivers/net/wan/pc300_tty.c:970:5:    expected void volatile [noderef]
*addr<asn:2>
drivers/net/wan/pc300_tty.c:970:5:    got unsigned char volatile
[addressable] [usertype] *<noident>

drivers/net/wan/pc300_tty.c:972:4: warning: incorrect type in argument 2
(different address spaces)
drivers/net/wan/pc300_tty.c:972:4:    expected void volatile [noderef]
*addr<asn:2>
drivers/net/wan/pc300_tty.c:972:4:    got unsigned short volatile
[addressable] [usertype] *<noident>

drivers/video/radeonfb.c:758:23: warning: dereference of noderef
expression

drivers/video/radeonfb.c:758:58: warning: dereference of noderef
expression

drivers/video/radeonfb.c:770:48: warning: dereference of noderef
expression

drivers/video/radeonfb.c:771:58: warning: incorrect type in argument 2
(different address spaces)
drivers/video/radeonfb.c:771:58:    expected char const *ct
drivers/video/radeonfb.c:771:58:    got char [noderef] *[assigned]
rom<asn:2>

drivers/video/radeonfb.c:784:50: warning: dereference of noderef
expression

drivers/video/radeonfb.c:785:60: warning: incorrect type in argument 2
(different address spaces)
drivers/video/radeonfb.c:785:60:    expected char const *ct
drivers/video/radeonfb.c:785:60:    got char [noderef] *[assigned]
rom<asn:2>




