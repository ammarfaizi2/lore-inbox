Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315266AbSEQBoS>; Thu, 16 May 2002 21:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315267AbSEQBoS>; Thu, 16 May 2002 21:44:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24982 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315266AbSEQBoR>;
	Thu, 16 May 2002 21:44:17 -0400
Date: Thu, 16 May 2002 18:31:02 -0700 (PDT)
Message-Id: <20020516.183102.56532896.davem@redhat.com>
To: jgarzik@mandrakesoft.com
Cc: andrew.grover@intel.com, mochel@osdl.org, Greg@kroah.com,
        linux-kernel@vger.kernel.org
Subject: Re: pci segments/domains
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3CE4098E.2070808@mandrakesoft.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@mandrakesoft.com>
   Date: Thu, 16 May 2002 15:33:34 -0400
   
   alpha and sparc64 at least already do them.
   
   I wouldn't mind making the PCI domain support a bit more explicit, 
   though.  I think it's fair to be able to obtain a pointer to "struct 
   pci_domain", which would most likely be defined in asm/pci.h for each arch.
   
We are going to end up soon with generic devices in 2.5.x
and we might as well end up with a "struct bus" too, which
can provide the domain abstraction in a bus-type independant
way.
