Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316614AbSEQRGp>; Fri, 17 May 2002 13:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316621AbSEQRGo>; Fri, 17 May 2002 13:06:44 -0400
Received: from pizda.ninka.net ([216.101.162.242]:16030 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316614AbSEQRGn>;
	Fri, 17 May 2002 13:06:43 -0400
Date: Fri, 17 May 2002 09:53:18 -0700 (PDT)
Message-Id: <20020517.095318.112045283.davem@redhat.com>
To: ink@jurassic.park.msu.ru
Cc: jgarzik@mandrakesoft.com, andrew.grover@intel.com, mochel@osdl.org,
        Greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: pci segments/domains
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020517202403.A28687@jurassic.park.msu.ru>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
   Date: Fri, 17 May 2002 20:24:03 +0400

   On Fri, May 17, 2002 at 10:42:44AM -0400, Jeff Garzik wrote:
   > Makes sense, sure :)  I just want to get rid of the untyped sysdata in 
   > favor of a struct with a defined type (arch-defined... but named and 
   > defined nonetheless).
   
   Just to be sure, do you mean both struct pci_bus and struct pci_dev? :-)
   On alpha both sysdata's are pointers to the same thing, but not on sparc
   as far as I can see.
   
Just do the struct pci_bus one for now.
