Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317488AbSHOUrx>; Thu, 15 Aug 2002 16:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317489AbSHOUrw>; Thu, 15 Aug 2002 16:47:52 -0400
Received: from hdfdns02.hd.intel.com ([192.52.58.11]:52964 "EHLO
	mail2.hd.intel.com") by vger.kernel.org with ESMTP
	id <S317488AbSHOUrv>; Thu, 15 Aug 2002 16:47:51 -0400
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DD9F@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Prasanna Subash'" <subash@skyline.external.hp.com>,
       linux-kernel@vger.kernel.org
Subject: RE: Compile error on 2.5.31 with CONFIG_SOFTWARE_SUSPEND
Date: Thu, 15 Aug 2002 13:51:38 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Prasanna Subash [mailto:subash@skyline.external.hp.com] 
> 	I get a compile error on 2.5.31 when I enable 
> CONFIG_SOFTWARE_SUSPEND.
> 
> This is the error I get.
> 
> drivers/built-in.o: In function `acpi_system_suspend':
> drivers/built-in.o(.text+0x39a1e): undefined reference to `save_flags'
> drivers/built-in.o(.text+0x39a4b): undefined reference to 
> `restore_flags'
> 
> 	I noticed that the include/asm-i386 did not have the 
> save_flags and 
> restore_flags macros while every other arch directory seems 
> to have the 
> #define'd.

This is fixed in my tree (thanks to Pavel) and will be included in the next
ACPI update to Linus.

Regards -- Andy
