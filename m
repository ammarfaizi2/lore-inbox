Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267447AbSLLKCC>; Thu, 12 Dec 2002 05:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267450AbSLLKCC>; Thu, 12 Dec 2002 05:02:02 -0500
Received: from PA1-1C-u-0320.mc.onolab.com ([62.42.201.65]:21376 "EHLO
	auditoriabalear.com") by vger.kernel.org with ESMTP
	id <S267447AbSLLKCB>; Thu, 12 Dec 2002 05:02:01 -0500
Date: Thu, 12 Dec 2002 11:08:23 +0100
From: Nico <nico@auditoriabalear.com>
Message-Id: <200212121008.gBCA8ND04353@auditoriabalear.com>
To: linux-kernel@vger.kernel.org
Subject: free entry in gdt_table
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello

I have a doubt, in kernels like 2.4.18 the second entry in gdt is not used

ENTRY(gdt_table)
        .quad 0x0000000000000000	/* NULL descriptor */
	.quad 0x0000000000000000	/* not used */
	.quad 0x00cf9a000000ffff	/* 0x10 kernel 4GB code at 0x00000000 */

there are 4 bytes lost!        

Why?
