Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315580AbSEQKyL>; Fri, 17 May 2002 06:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315588AbSEQKyK>; Fri, 17 May 2002 06:54:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14235 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315580AbSEQKyK>;
	Fri, 17 May 2002 06:54:10 -0400
Date: Fri, 17 May 2002 03:40:48 -0700 (PDT)
Message-Id: <20020517.034048.34092752.davem@redhat.com>
To: ink@jurassic.park.msu.ru
Cc: jgarzik@mandrakesoft.com, andrew.grover@intel.com, mochel@osdl.org,
        Greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: pci segments/domains
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020517144755.A16767@jurassic.park.msu.ru>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
   Date: Fri, 17 May 2002 14:47:55 +0400

   I can think of the only case where domain info might be interesting - if
   some device wants to know whether it can talk to another device directly.
   We have pci_controller_num(pdev) for this.

That is an insufficient way to determine this.  Maybe I can make two
PCI devices talk to each other transparently between two domains
using an IOMMU?
