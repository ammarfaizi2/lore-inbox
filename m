Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279926AbRKBB7S>; Thu, 1 Nov 2001 20:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279927AbRKBB7I>; Thu, 1 Nov 2001 20:59:08 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:56976 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S279926AbRKBB6v>; Thu, 1 Nov 2001 20:58:51 -0500
Date: Thu, 01 Nov 2001 17:59:22 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: What is pci_root_bus?
Message-ID: <3910182157.1004637562@[10.10.1.2]>
X-Mailer: Mulberry/2.0.5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is pci_root_bus used for (i386)?

As far as I can see, nothing except pirq_peer_trick(), which just
pulls the ops pointer out of it ....

Seems somewhat redundant, especially as there's a pci_root_buses
list ....

Thanks,

Martin

PS. Not just an idle question, I'm trying to set up the PCI buses for
every node of a NUMA box.


