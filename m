Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271741AbRHUWjk>; Tue, 21 Aug 2001 18:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271880AbRHUWjb>; Tue, 21 Aug 2001 18:39:31 -0400
Received: from pizda.ninka.net ([216.101.162.242]:31650 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271859AbRHUWjV>;
	Tue, 21 Aug 2001 18:39:21 -0400
Date: Tue, 21 Aug 2001 15:39:34 -0700 (PDT)
Message-Id: <20010821.153934.112610604.davem@redhat.com>
To: linux-kernel@vger.kernel.org
CC: axboe@suse.de
Subject: [UPDATE] PCI64 patch 2.4.9-2
From: "David S. Miller" <davem@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I posted a new revision of the pci64 patches:

ftp.kernel.org/pub/linux/kernel/people/davem/PCI64/pci64-2.4.9-2.patch.{gz,bz2}

Changes:

	1) Fix 64-bit addressing capability detection
	   in SunGEM driver, only SunGEM PCI boards
	   can do it.  Sun onboard and PPC GEMs cannot.
	2) Add pci64_*() variants of PCI pool allocation
	   and freeing.
	3) Document #2

Later,
David S. Miller
davem@redhat.com
