Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279771AbRJ0DcA>; Fri, 26 Oct 2001 23:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279772AbRJ0Dbu>; Fri, 26 Oct 2001 23:31:50 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:31243 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S279771AbRJ0Dbe>;
	Fri, 26 Oct 2001 23:31:34 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Non-standard MODULE_LICENSEs in 2.4.13-ac2
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 27 Oct 2001 13:31:56 +1000
Message-ID: <13064.1004153516@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are the non-standard MODULE_LICENSEs in 2.4.13-ac2, compiling
these as modules will result in a tainted kernel.  "BSD without
advertising clause" is not quite good enough for the kernel, that
licence allows for binary only modules.  Kernel debuggers insist on
general source availability.

Since the source is already in the kernel which is distributed as a GPL
work, these sources are effectively dual BSD/GPL.  Could the owners
please convert them to "Dual BSD/GPL"?

net/ipv4/netfilter/ipchains_core.c:MODULE_LICENSE("BSD without advertisement clause");
fs/nls/nls_cp874.c:MODULE_LICENSE("BSD without advertising clause");
fs/nls/nls_cp869.c:MODULE_LICENSE("BSD without advertising clause");
fs/nls/nls_cp866.c:MODULE_LICENSE("BSD without advertising clause");
fs/nls/nls_cp865.c:MODULE_LICENSE("BSD without advertising clause");
fs/nls/nls_cp864.c:MODULE_LICENSE("BSD without advertising clause");
fs/nls/nls_cp863.c:MODULE_LICENSE("BSD without advertising clause");
fs/nls/nls_cp862.c:MODULE_LICENSE("BSD without advertising clause");
fs/nls/nls_cp861.c:MODULE_LICENSE("BSD without advertising clause");
fs/nls/nls_cp860.c:MODULE_LICENSE("BSD without advertising clause");
fs/nls/nls_cp857.c:MODULE_LICENSE("BSD without advertising clause");
fs/nls/nls_cp855.c:MODULE_LICENSE("BSD without advertising clause");
fs/nls/nls_cp852.c:MODULE_LICENSE("BSD without advertising clause");
fs/nls/nls_cp850.c:MODULE_LICENSE("BSD without advertising clause");
fs/nls/nls_cp775.c:MODULE_LICENSE("BSD without advertising clause");
fs/nls/nls_cp737.c:MODULE_LICENSE("BSD without advertising clause");
fs/nls/nls_cp437.c:MODULE_LICENSE("BSD without advertising clause");
fs/nls/nls_cp1255.c:MODULE_LICENSE("BSD without advertising clause");
fs/nls/nls_cp1251.c:MODULE_LICENSE("BSD without advertising clause");
drivers/scsi/pci2220i.c:MODULE_LICENSE("BSD without advertising clause");
drivers/scsi/u14-34f.c:MODULE_LICENSE("BSD without advertisement clause");
drivers/scsi/pci2000.c:MODULE_LICENSE("BSD without advertisement clause");
drivers/scsi/eata.c:MODULE_LICENSE("BSD");
drivers/scsi/advansys.c:MODULE_LICENSE("BSD without advertising clause");
drivers/net/pcmcia/wavelan_cs.c:MODULE_LICENSE("BSD without advertisement clause");
drivers/net/ppp_deflate.c:MODULE_LICENSE("BSD without advertisement clause");
drivers/net/bsd_comp.c:MODULE_LICENSE("BSD without advertising clause");
drivers/net/strip.c:MODULE_LICENSE("BSD without advertisement clause");
drivers/net/slhc.c:MODULE_LICENSE("BSD without advertising clause");

