Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262517AbUJ0RMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbUJ0RMj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 13:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbUJ0RL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 13:11:59 -0400
Received: from build.arklinux.osuosl.org ([128.193.0.51]:53646 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S262517AbUJ0Q03
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 12:26:29 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: LINUX4MEDIA GmbH
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: 2.6.10-rc1-mm1 doesn't compile on x86_64
Date: Wed, 27 Oct 2004 18:21:36 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410271821.37339.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86_64/kernel/built-in.o(.text+0x6265): In function `timer_resume':
: undefined reference to `is_hpet_enabled'
arch/x86_64/kernel/built-in.o(.init.text+0x862b): In function 
`pci_iommu_init':
: undefined reference to `agp_amd64_init'
arch/x86_64/kernel/built-in.o(.init.text+0x8639): In function 
`pci_iommu_init':
: undefined reference to `agp_copy_info'
make: *** [.tmp_vmlinux1] Error 1

Will debug later unless someone beats me to it.
