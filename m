Return-Path: <linux-kernel-owner+w=401wt.eu-S932728AbWLNNyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932728AbWLNNyn (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 08:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932729AbWLNNyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 08:54:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4440 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932728AbWLNNym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 08:54:42 -0500
Date: Thu, 14 Dec 2006 14:54:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.16.36
Message-ID: <20061214135449.GF3629@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Location:
ftp://ftp.kernel.org/pub/linux/kernel/v2.6/

git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git

RSS feed of the git tree:
http://www.kernel.org/git/?p=linux/kernel/git/stable/linux-2.6.16.y.git;a=rss


Changes since 2.6.16.35:

Adrian Bunk (3):
      revert the quirk_via_irq changes
      Linux 2.6.16.36-rc1
      Linux 2.6.16.36

Bjorn Helgaas (1):
      PCI: quirk to disable e100 interrupt if RESET failed to

Brice Goglin (1):
      PCI: nVidia quirk to make AER PCI-E extended capability visible

Chuck Ebbert (1):
      binfmt_elf: fix checks for bad address

Daniel Ritz (2):
      PCI: fix ICH6 quirks
      PCI: add ICH7/8 ACPI/GPIO io resource quirks

David S. Miller (1):
      [IPSEC]: Fix inetpeer leak in ipv4 xfrm dst entries.

Jean Delvare (1):
      PCI: Unhide the SMBus on Asus PU-DLS

John W. Linville (1):
      pci_ids.h: correct naming of 1022:7450 (AMD 8131 Bridge)

Linus Torvalds (1):
      Add PIIX4 APCI quirk for the 440MX chipset too

Patrick McHardy (1):
      [XFRM]: Use output device disable_xfrm for forwarded packets

Ralf Baechle (1):
      Fix mempolicy.h build error


 Makefile                  |    2 
 drivers/pci/quirks.c      |  101 ++++++++++++++++++++++++++++++++++----
 fs/binfmt_elf.c           |   15 ++---
 include/linux/mempolicy.h |    1 
 include/linux/pci_ids.h   |    5 +
 net/ipv4/route.c          |    2 
 net/ipv4/xfrm4_policy.c   |    2 
 7 files changed, 109 insertions(+), 19 deletions(-)
