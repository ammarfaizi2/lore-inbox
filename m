Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbTJISV6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 14:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbTJISV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 14:21:58 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:3968 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S262372AbTJISV5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 14:21:57 -0400
Date: Thu, 9 Oct 2003 14:21:54 -0400
From: Yaroslav Halchenko <kernel@onerussian.com>
To: linux-kernel@vger.kernel.org
Subject: test7 (and earlier > test1 for sure) crash on boot acpiphp_glue_init
Message-ID: <20031009182154.GA1219@washoe.rutgers.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Developers,

My desktop/server has been running 2.6.0-test1 kernel for a while and
recently I decided to try new ones but it crashes early on boot giving
me dump on test7 ( as well I've tried test6-bk9 before with the same
crash). pci=noacpi and then acpi=off didn't help - problem persisted

acpi_glue_init+0x1b/0x30
init_acpi+0x6/0x30
acpiphp_init+0x27/0x40
do_initcalls+0x2c/0xa0
....

Configuration and some system detailes are on 

http://www.onerussian.com/Linux/bugs/washoe.test7

Please give me any idea how I can help?

Thank you in advance
                                  .-.
=------------------------------   /v\  ----------------------------=
Keep in touch                    // \\     (yoh@|www.)onerussian.com
Yaroslav Halchenko              /(   )\               ICQ#: 60653192
                   Linux User    ^^-^^    [175555]
