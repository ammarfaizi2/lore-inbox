Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315850AbSEQMae>; Fri, 17 May 2002 08:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315374AbSEQM3M>; Fri, 17 May 2002 08:29:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8348 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315372AbSEQM2l>;
	Fri, 17 May 2002 08:28:41 -0400
Date: Fri, 17 May 2002 05:15:18 -0700 (PDT)
Message-Id: <20020517.051518.35579118.davem@redhat.com>
To: ink@jurassic.park.msu.ru
Cc: jgarzik@mandrakesoft.com, andrew.grover@intel.com, mochel@osdl.org,
        Greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: pci segments/domains
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020517162621.A24213@jurassic.park.msu.ru>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
   Date: Fri, 17 May 2002 16:26:21 +0400
   
   BTW, I don't see anymore why pci domain info should be exposed to
   users at all. :-)

It allows the X server do what it wants to sort-of sanely.

It wants to be able to assign resources to video devices (even
implicit resources like VGA) and to do that properly it has to know
which PCI domain which devices are on and also the extent of the I/O
and MEM space on that domain.
