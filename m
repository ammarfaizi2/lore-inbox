Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271736AbRHQWyU>; Fri, 17 Aug 2001 18:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271742AbRHQWyK>; Fri, 17 Aug 2001 18:54:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:6273 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271736AbRHQWxz>;
	Fri, 17 Aug 2001 18:53:55 -0400
Date: Fri, 17 Aug 2001 15:53:54 -0700 (PDT)
Message-Id: <20010817.155354.85420212.davem@redhat.com>
To: alex.buell@tahallah.demon.co.uk
Cc: alan@lxorguk.ukuu.org.uk, andre.dahlqvist@telia.com,
        linux-kernel@vger.kernel.org
Subject: Re: 'make dep' produces lots of errors with this .config
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0108172344000.14197-100000@tahallah.demon.co.uk>
In-Reply-To: <E15Xs2d-0008EK-00@the-village.bc.nu>
	<Pine.LNX.4.33.0108172344000.14197-100000@tahallah.demon.co.uk>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alex Buell <alex.buell@tahallah.demon.co.uk>
   Date: Fri, 17 Aug 2001 23:48:29 +0100 (BST)
   
   That won't fix the PCI references which seems to get compiled in if
   asm/keyboard.h is included. Taking a look at it, hmm. asm-sparc/keyboard.h
   seems to be for the Ultra/PCI stuff, oughtn't this be in asm-sparc64, as
   sparc32 doesn't use PCI at all, unless there's something I don't know.

Ummm, there are most definitely PCI sparc32 systems.

Later,
David S. Miller
davem@redhat.com
