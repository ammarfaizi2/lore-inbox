Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWIAEIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWIAEIn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 00:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWIAEIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 00:08:43 -0400
Received: from ip2.cbn.net.id ([210.210.145.57]:11072 "EHLO ip2.cbn.net.id")
	by vger.kernel.org with ESMTP id S1751112AbWIAEIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 00:08:42 -0400
X-SBRS-Score: None
X-HAT: Sender Group SMTP_Webmail, Policy $IP2_Outbound_Webmail applied.
X-IronPort-AV: i="4.08,196,1154883600"; 
   d="scan'208"; a="202399029:sNHT698172510"
Message-ID: <1816.202.171.0.72.1157083717.CBNWebMail@webmail2.cbn.net.id>
Date: Fri, 1 Sep 2006 11:08:37 +0700 (WIT)
Subject: Help in kernel error
From: "Dapid Candra" <dapidc@cbn.net.id>
To: linux-kernel@vger.kernel.org
User-Agent: CBN WebMail/2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got the following messages just before my server freeze.

The server is now served as Oracle database server. It is also using
external storage connected by SCSI. It runs Red Hat EL AS 4.0. And it has
4GB RAM.

Any help on this problems would be greatly appreciated.

TIA

Dapid Candra


--------
Aug 31 23:02:27 hqdmsdb01 kernel: kernel BUG at kernel/exit.c:840!
Aug 31 23:02:27 hqdmsdb01 kernel: invalid operand: 0000 [#1]
Aug 31 23:02:27 hqdmsdb01 kernel: SMP
Aug 31 23:02:27 hqdmsdb01 kernel: Modules linked in: aic7xxx
iptable_filter ip_tables st nfsd exportfs lockd parport_pc lp parpo
rt autofs4 i2c_dev i2c_core sunrpc md5 ipv6 button battery ac uhci_hcd
ehci_hcd e1000 floppy sg dm_snapshot dm_zero dm_mirror ex
t3 jbd dm_mod megaraid_mbox megaraid_mm mptscsih mptbase sd_mod scsi_mod
Aug 31 23:02:27 hqdmsdb01 kernel: CPU:    0
Aug 31 23:02:27 hqdmsdb01 kernel: EIP:    0060:[<c0122c26>]    Not tainted
VLI
Aug 31 23:02:27 hqdmsdb01 kernel: EFLAGS: 00010246   (2.6.9-5.ELsmp)
Aug 31 23:02:27 hqdmsdb01 kernel: EIP is at do_exit+0x3b6/0x3c0
Aug 31 23:02:27 hqdmsdb01 kernel: eax: 00000000   ebx: de461d70   ecx:
de461800   edx: c363bd60
Aug 31 23:02:27 hqdmsdb01 kernel: esi: f7ffb680   edi: de461830   ebp:
00000000   esp: e22b1fdc
Aug 31 23:02:27 hqdmsdb01 kernel: ds: 007b   es: 007b   ss: 0068
Aug 31 23:02:27 hqdmsdb01 kernel: Process pdflush (pid: 28041,
threadinfo=e22b1000 task=de461830)
Aug 31 23:02:27 hqdmsdb01 kernel: Stack: c0131d5a 00000000 00000000
00000000 c01041f7 00000000 cc040f44 00000000
Aug 31 23:02:27 hqdmsdb01 kernel:        00000000
Aug 31 23:02:27 hqdmsdb01 kernel: Call Trace:
Aug 31 23:02:27 hqdmsdb01 kernel:  [<c0131d5a>] kthread+0x0/0x9b
Aug 31 23:02:27 hqdmsdb01 kernel:  [<c01041f7>] kernel_thread+0x0/0x72
Aug 31 23:02:27 hqdmsdb01 kernel: Code: 8d 04 02 ff 88 00 01 00 00 83 3a
02 75 0b 8b 82 08 11 00 00 e8 11 8e ff ff 89 af 80 00 0
0 00 89 f8 e8 bd f5 ff ff e8 ea 10 1a 00 <0f> 0b 48 03 f2 77 2d c0 eb fe
53 85 c0 89 d3 74 05 e8 59 a3 ff
Aug 31 23:02:27 hqdmsdb01 kernel:  <1>Unable to handle kernel NULL pointer
dereference at virtual address 00000044
Aug 31 23:02:27 hqdmsdb01 kernel:  printing eip:
Aug 31 23:02:27 hqdmsdb01 kernel: c0122b9d
Aug 31 23:02:27 hqdmsdb01 kernel: *pde = 0ed9e001
Aug 31 23:02:27 hqdmsdb01 kernel: Oops: 0000 [#2]
Aug 31 23:02:27 hqdmsdb01 kernel: SMP
Aug 31 23:02:27 hqdmsdb01 kernel: Modules linked in: aic7xxx
iptable_filter ip_tables st nfsd exportfs lockd parport_pc lp parpo
rt autofs4 i2c_dev i2c_core sunrpc md5 ipv6 button battery ac uhci_hcd
ehci_hcd e1000 floppy sg dm_snapshot dm_zero dm_mirror ex
t3 jbd dm_mod megaraid_mbox megaraid_mm mptscsih mptbase sd_mod scsi_mod
Aug 31 23:02:27 hqdmsdb01 kernel: CPU:    0
Aug 31 23:02:27 hqdmsdb01 kernel: EIP:    0060:[<c0122b9d>]    Not tainted
VLI
Aug 31 23:02:27 hqdmsdb01 kernel: EFLAGS: 00010246   (2.6.9-5.ELsmp)
Aug 31 23:02:27 hqdmsdb01 kernel: EIP is at do_exit+0x32d/0x3c0
Aug 31 23:02:27 hqdmsdb01 kernel: eax: 00000000   ebx: 00000000   ecx:
00000000   edx: e22b1000
Aug 31 23:02:27 hqdmsdb01 kernel: esi: 00000000   edi: de461830   ebp:
0000000b   esp: e22b1ea8
Aug 31 23:02:27 hqdmsdb01 kernel: ds: 007b   es: 007b   ss: 0068
Aug 31 23:02:27 hqdmsdb01 kernel: Process pdflush (pid: 28041,
threadinfo=e22b1000 task=de461830)
Aug 31 23:02:27 hqdmsdb01 kernel: Stack: e22b1000 e22b1fa8 00000000
c02d0229 c0106047 0000000b e22b1fa8 c02d0229
