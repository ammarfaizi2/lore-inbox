Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315721AbSHMPGj>; Tue, 13 Aug 2002 11:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316047AbSHMPGh>; Tue, 13 Aug 2002 11:06:37 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:27640 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315721AbSHMPGg>; Tue, 13 Aug 2002 11:06:36 -0400
Subject: Re: [patch] PCI Cleanup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: colpatch@us.ibm.com, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Greg KH <gregkh@us.ibm.com>
In-Reply-To: <1849271812.1029225314@[10.10.2.3]>
References: <1029239133.20980.10.camel@irongate.swansea.linux.org.uk> 
	<1849271812.1029225314@[10.10.2.3]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Aug 2002 16:07:57 +0100
Message-Id: <1029251277.22847.42.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-13 at 15:55, Martin J. Bligh wrote:
> BTW, it wasn't just resent, it had all the NUMA-Q stuff stripped out
> of it, and was just the core code cleanup. He's replacing 
> pci_conf1_read_config_byte and pci_conf2_read_config_byte

Apologies that part of the changing between the two diffs I didn't
notice. I've just stripped the value check out of 2.4 except for the
BIOS mode ones (they tend to produce -weird- tracebacks) where it
BUG()'s on that.


