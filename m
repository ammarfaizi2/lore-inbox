Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161404AbWHDUlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161404AbWHDUlE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 16:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161405AbWHDUlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 16:41:04 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:5339 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1161404AbWHDUlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 16:41:03 -0400
Date: Fri, 4 Aug 2006 17:40:48 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Thomas Backlund <tmb@mandriva.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Hangs, EIP is at scsi_decide_disposition
Message-ID: <20060804174048.14365f83@doriath.conectiva>
In-Reply-To: <eatsgi$iov$1@sea.gmane.org>
References: <20060803154237.12936.qmail@web51002.mail.yahoo.com>
	<eatsgi$iov$1@sea.gmane.org>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.4.0-rc4 (GTK+ 2.10.1; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 04 Aug 2006 01:15:07 +0300
Thomas Backlund <tmb@mandriva.org> escreveu:

| Richard Mollel wrote:
| > Our mandriva boxes are randomly crushing after
| > migration to 2006.0 download version. The same
| > hardware has had mandriva 10.0 withuptimes of over 230
| > days....but nowadays it is hardly a week before a
| > crash for over 6 nodes with latest kernels.
| > 
| 
| The correct place to report this is:
| 
| http://qa.mandriva.com/
| 
| 
| > I captured one of our lockups and am attaching the
| > output of ksymoops for further interpretation by mroe
| > experienced eyes when it comes to kernel internals.
| > 
| > Here is the actual error, and attached, the ksymoops
| > interpretation of it.
| > 
| > Unable to handle kernel NULL pointer dereference at
| > virtual address 000002a9
| >  printing eip:
| > f88642bd
| > *pde = 3702b001
| > Oops: 0000 [#1]
| > SMP
| > Modules linked in: sg nfsd exportfs raw md5 ipv6 nfs
| > lockd nfs_acl sunrpc parport_pc lp parport e1000
| > af_packet floppy video thermal tc1100_wmi processor
| > fan container button battery ac ipt_LOG ipt_REJECT
| > ipt_state ip_conntrack iptable_filter ip_tables ide_cd
| > loop hw_random 3w_9xxx tsdev sr_mod ehci_hcd uhci_hcd
| > usbcore evdev reiserfs sd_mod ahci ata_piix libata
| > scsi_mod
| > CPU:    0
| > EIP:    0060:[<f88642bd>]    Tainted: G   M  VLI
| > EFLAGS: 00010282   (2.6.12-22mdksmp)
| 
| Can you reproduce with an untainted kernel ??
| 
| This is what you also need to report to the above mentioned address...

 Known issue:

http://qa.mandriva.com/show_bug.cgi?id=19593

 Richard, it's a very hard to trace problem. Please add a comment
there if you can reproduce it w/o having to run your test-case for a
week.

-- 
Luiz Fernando N. Capitulino
