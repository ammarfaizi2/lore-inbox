Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272549AbRH3XPE>; Thu, 30 Aug 2001 19:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272550AbRH3XOy>; Thu, 30 Aug 2001 19:14:54 -0400
Received: from pizda.ninka.net ([216.101.162.242]:58515 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272549AbRH3XOs>;
	Thu, 30 Aug 2001 19:14:48 -0400
Date: Thu, 30 Aug 2001 16:14:53 -0700 (PDT)
Message-Id: <20010830.161453.130817352.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: kraxel@bytesex.org, linux-kernel@vger.kernel.org
Subject: Re: [UPDATE] 2.4.10-pre2 PCI64, API changes README
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E15cb0w-00025m-00@the-village.bc.nu>
In-Reply-To: <20010830.160651.75218604.davem@redhat.com>
	<E15cb0w-00025m-00@the-village.bc.nu>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Fri, 31 Aug 2001 00:14:22 +0100 (BST)
   
   Thats an API video overlay really really needs of course - because DMA from
   the capture card into the video memory is precisely how its done.

Ok, then it is important to figure out if there is going to be a
suitable way to get at the two pci_dev's.

If mmap()'ing the frame buffer and passing this into read() is how
this will be done, it simply won't work.  That's the point I'm trying
to make.

Later,
David S. Miller
davem@redhat.com
