Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965283AbVKHTZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965283AbVKHTZS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 14:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965278AbVKHTZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 14:25:17 -0500
Received: from web34105.mail.mud.yahoo.com ([66.163.178.103]:64645 "HELO
	web34105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965280AbVKHTZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 14:25:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=1rHijpfQSDI0BH7kqVneqS6G/KD6DzDjPyEN6+VDUcnkusvcoPo4r9CMBIYGAd0aVPQTUMO5XobY6gIeAhG4rxVILcbA5JXdyNLu20H0tFE4BzYcFw1eOhaUsDuCfZuNEdWRcPPwokTEemUKKq0i36hwgmAAGybosgt1oKDrW30=  ;
Message-ID: <20051108192515.17247.qmail@web34105.mail.mud.yahoo.com>
Date: Tue, 8 Nov 2005 11:25:15 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: re: mmap over nfs leads to excessive system load
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just another data point....
If I open the file with O_DIRECT.. not much changes:

samples  %        image name               app name                 symbol name
12585321 18.9373  vmlinux-2.6.14           vmlinux-2.6.14           find_get_pages_tag
8608887  12.9539  vmlinux-2.6.14           vmlinux-2.6.14           mpage_writepages
6870600  10.3383  vmlinux-2.6.14           vmlinux-2.6.14           unlock_page
6605417   9.9393  vmlinux-2.6.14           vmlinux-2.6.14           clear_page_dirty_for_io
6259207   9.4183  vmlinux-2.6.14           vmlinux-2.6.14           release_pages
3249493   4.8896  vmlinux-2.6.14           vmlinux-2.6.14           __lookup_tag
3248871   4.8886  vmlinux-2.6.14           vmlinux-2.6.14           pci_conf1_write
2677914   4.0295  vmlinux-2.6.14           vmlinux-2.6.14           page_waitqueue
982811    1.4789  vmlinux-2.6.14           vmlinux-2.6.14           _read_lock_irqsave
917165    1.3801  vmlinux-2.6.14           vmlinux-2.6.14           _read_unlock_irq
758960    1.1420  vmlinux-2.6.14           vmlinux-2.6.14           __wake_up_bit
706607    1.0632  vmlinux-2.6.14           vmlinux-2.6.14           _spin_lock_irqsave


-Kenny



	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
