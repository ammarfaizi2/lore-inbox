Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264953AbUFRBmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbUFRBmH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 21:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264943AbUFRBj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 21:39:29 -0400
Received: from pimout6-ext.prodigy.net ([207.115.63.78]:2298 "EHLO
	pimout6-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264920AbUFRBfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 21:35:15 -0400
Message-ID: <40D20080.9040909@ameritech.net>
Date: Thu, 17 Jun 2004 20:35:12 +0000
From: water modem <lundby@ameritech.net>
Organization: home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: undefined reference to `acpi_processor_register_performance
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.7 compile error

   LD      .tmp_vmlinux1
arch/i386/kernel/built-in.o(.text+0xcfeb): In function 
`powernow_acpi_init':
: undefined reference to `acpi_processor_register_performance'
arch/i386/kernel/built-in.o(.text+0xd01c): In function 
`powernow_acpi_init':
: undefined reference to `acpi_processor_unregister_performance'
arch/i386/kernel/built-in.o(.exit.text+0x32): In function `powernow_exit':
: undefined reference to `acpi_processor_unregister_performance'
make: *** [.tmp_vmlinux1] Error 1
[root@enlaptop linux-2.6.7]#

