Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbTJMV0Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 17:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbTJMV0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 17:26:25 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:18816 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S261966AbTJMV0X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 17:26:23 -0400
Date: Mon, 13 Oct 2003 17:26:23 -0400
From: Yaroslav Halchenko <kernel@onerussian.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: oops early at the boot time
Message-ID: <20031013212622.GA1221@washoe.rutgers.edu>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Developers,

My desktop/server has been running 2.6.0-test1 kernel for a while and
recently I decided to try new ones but it crashes early on boot giving
me dump on test7-bk5 (as well I've tried test6-bk9 before with the same
crash). pci=noacpi and then acpi=off didn't help - problem persisted


Oops: 0000 [#1]
CPU : 0
EIP: 0060:[<c02312a0>] Not tainted
EFLAGS: 00010286
EIP is at acpi_pci_register_driver+0x30/0x5c
eax: c05432d8 ebx: 00000000 ecx:c045d934   edx: 000000000
esi: c0494514 edi: 00000000 ....
......
acpi_glue_init+0x1b/0x30
init_acpi+0x6/0x30
acpiphp_init+0x27/0x40
do_initcalls+0x2c/0xa0
....

Configuration and some system details are on 

http://www.onerussian.com/Linux/bugs/washoe.test7

Please give me any idea how I can help?

Thank you in advance  
                                  .-.
=------------------------------   /v\  ----------------------------=
Keep in touch                    // \\     (yoh@|www.)onerussian.com
Yaroslav Halchenko              /(   )\               ICQ#: 60653192
                   Linux User    ^^-^^    [175555]
