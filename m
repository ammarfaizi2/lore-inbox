Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316248AbSEQOkm>; Fri, 17 May 2002 10:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316247AbSEQOj6>; Fri, 17 May 2002 10:39:58 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24733 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316252AbSEQOjs>;
	Fri, 17 May 2002 10:39:48 -0400
Date: Fri, 17 May 2002 07:26:25 -0700 (PDT)
Message-Id: <20020517.072625.29433758.davem@redhat.com>
To: jgarzik@mandrakesoft.com
Cc: ink@jurassic.park.msu.ru, andrew.grover@intel.com, mochel@osdl.org,
        Greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: pci segments/domains
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3CE514B6.6070302@mandrakesoft.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@mandrakesoft.com>
   Date: Fri, 17 May 2002 10:33:26 -0400

   My main want is cosmetic -- call a spade a spade, so to speak. 
    s/sysdata/pci_domain/  But doing so opens the door to increased 
   flexibility.  Later steps can add common members needed by pci-to-pci 
   IOMMU tricks which are common to most platforms.

Since the name really doesn't matter let's call it struct pci_controller
since that is what Alpha and Sparc use already :-)
