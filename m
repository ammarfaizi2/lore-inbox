Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263119AbTJUOyE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 10:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263120AbTJUOyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 10:54:04 -0400
Received: from mclean-vscan4.bah.com ([156.80.3.64]:21173 "EHLO
	mclean-vscan4.bah.com") by vger.kernel.org with ESMTP
	id S263119AbTJUOyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 10:54:00 -0400
Message-ID: <3F954881.1030508@bah.com>
Date: Tue, 21 Oct 2003 10:53:54 -0400
From: "Suh Jin" <suh_jin@bah.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test8 modules_install unresolved symbol errors
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could someone help me why I am getting unresolved symbols when I run 
"make modules_install". How do I fix those? I am using RedHat9.0 and I 
have same problems using gcc2.95.3 and gcc3.2.2. BTW, it doesn't matter 
mm1 patch or vanilla kernel.

depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-mm1/kernel/net/ipv4/ipvs/ip_vs_wlc.ko
depmod:         register_ip_vs_scheduler
depmod:         unregister_ip_vs_scheduler
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-mm1/kernel/net/ipv4/ipvs/ip_vs_wrr.ko
depmod:         register_ip_vs_scheduler
depmod:         unregister_ip_vs_scheduler
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-mm1/kernel/net/ipv4/netfilter/arptable_filter.ko
depmod:         arpt_register_table
depmod:         arpt_do_table
depmod:         arpt_unregister_table
........ bunch of more unresolved symbols

Thanks,
Jin


