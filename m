Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbTBNQi3>; Fri, 14 Feb 2003 11:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbTBNQi2>; Fri, 14 Feb 2003 11:38:28 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:8064 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S261356AbTBNQi1>; Fri, 14 Feb 2003 11:38:27 -0500
Date: Fri, 14 Feb 2003 17:47:20 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, David Lang <david.lang@digitalinsight.com>,
       "Matthew D. Pitts" <mpitts@suite224.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: openbkweb-0.0
Message-ID: <20030214164720.GC200@louise.pinerecords.com>
References: <Pine.LNX.4.44.0302132224470.656-100000@dlang.diginsite.com> <1045233701.7958.14.camel@irongate.swansea.linux.org.uk> <20030214153039.GB3188@work.bitmover.com> <1045241763.1353.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045241763.1353.19.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [alan@lxorguk.ukuu.org.uk]
> 
> On Fri, 2003-02-14 at 15:30, Larry McVoy wrote:
> > Second of all, all of those reverse engineering clauses are dependent on
> > you having a legal copy of the software, full stop.  You can't get a 
> > legal copy if what you want to do, now or in the future, is to reverse
> > engineer the software.  
> 
> Go talk to an EU lawyer. These laws exist to stop people locking down
> formats and its one of the reasons you actually have things like
> open office
> 
> All I want is to be able to review the 3c990 patch. Right now I can't

Larry, would it be a problem to implement something like:

alan@wherever$ echo 'rq unidiff for {1.967,1.968} of typhoon/typhoon-2.4'| \
	mail diffmail@bkbits.net
...
You have mail in /var/spool/alan.
alan@wherever$ tail -17 /var/spool/alan
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h  --- a/include/linux/pci_ids.h	Mon Feb  3 16:41:40 2003
+++ b/include/linux/pci_ids.h	Thu Feb 13 22:42:01 2003
@@ -829,6 +829,14 @@
 #define PCI_DEVICE_ID_3COM_3C905TX	0x9050
 #define PCI_DEVICE_ID_3COM_3C905T4	0x9051
 #define PCI_DEVICE_ID_3COM_3C905B_TX	0x9055
+#define PCI_DEVICE_ID_3COM_3CR990	0x9900
+#define PCI_DEVICE_ID_3COM_3CR990_TX_95	0x9902
+#define PCI_DEVICE_ID_3COM_3CR990_TX_97	0x9903
+#define PCI_DEVICE_ID_3COM_3CR990B	0x9904
+#define PCI_DEVICE_ID_3COM_3CR990_FX	0x9905
+#define PCI_DEVICE_ID_3COM_3CR990SVR95	0x9908
+#define PCI_DEVICE_ID_3COM_3CR990SVR97	0x9909
+#define PCI_DEVICE_ID_3COM_3CR990SVR	0x990a
 
 #define PCI_VENDOR_ID_SMC		0x10b8
 #define PCI_DEVICE_ID_SMC_EPIC100	0x0005

-- 
Tomas Szepe <szepe@pinerecords.com>
