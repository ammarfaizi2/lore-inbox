Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264976AbUFRDRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264976AbUFRDRg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 23:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264979AbUFRDRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 23:17:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:30162 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264976AbUFRDRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 23:17:35 -0400
Date: Thu, 17 Jun 2004 20:12:43 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: water modem <lundby@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: undefined reference to `acpi_processor_register_performance
Message-Id: <20040617201243.4ebfc9b2.rddunlap@osdl.org>
In-Reply-To: <40D20080.9040909@ameritech.net>
References: <40D20080.9040909@ameritech.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004 20:35:12 +0000 water modem wrote:

| 2.6.7 compile error
| 
|    LD      .tmp_vmlinux1
| arch/i386/kernel/built-in.o(.text+0xcfeb): In function 
| `powernow_acpi_init':
| : undefined reference to `acpi_processor_register_performance'
| arch/i386/kernel/built-in.o(.text+0xd01c): In function 
| `powernow_acpi_init':
| : undefined reference to `acpi_processor_unregister_performance'
| arch/i386/kernel/built-in.o(.exit.text+0x32): In function `powernow_exit':
| : undefined reference to `acpi_processor_unregister_performance'
| make: *** [.tmp_vmlinux1] Error 1
| [root@enlaptop linux-2.6.7]#

got a .config for this?  i'm having a little trouble duplicating it.

thanks,
--
~Randy
