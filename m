Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315634AbSEQLRu>; Fri, 17 May 2002 07:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315822AbSEQLRs>; Fri, 17 May 2002 07:17:48 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28827 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315634AbSEQLRp>;
	Fri, 17 May 2002 07:17:45 -0400
Date: Fri, 17 May 2002 04:04:21 -0700 (PDT)
Message-Id: <20020517.040421.38226563.davem@redhat.com>
To: ink@jurassic.park.msu.ru
Cc: jgarzik@mandrakesoft.com, andrew.grover@intel.com, mochel@osdl.org,
        Greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: pci segments/domains
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020517151154.B16767@jurassic.park.msu.ru>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
   Date: Fri, 17 May 2002 15:11:54 +0400

   Hmm, not sure. I think it's impossible at least on alpha.
   In either case I don't see how "struct pci_domain" etc.
   could help in this case. Probably you'll need some mapping
   function with pdev1, pdev2 as arguments...
   
I'm not saying pci_domain structure will help, I am only
saying that domain number is not the way to figure out
the ability to do DMA between two devices :-)

I know for a fact that you can do PCI-to-PCI DMA between
two PCI domains on Alpha.

   
