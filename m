Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317678AbSFLJqn>; Wed, 12 Jun 2002 05:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317679AbSFLJqm>; Wed, 12 Jun 2002 05:46:42 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41423 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317678AbSFLJqm>;
	Wed, 12 Jun 2002 05:46:42 -0400
Date: Wed, 12 Jun 2002 02:42:24 -0700 (PDT)
Message-Id: <20020612.024224.60294929.davem@redhat.com>
To: benh@kernel.crashing.org
Cc: david-b@pacbell.net, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020611173347.21348@smtp.adsl.oleane.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
   Date: Tue, 11 Jun 2002 19:33:47 +0200

   >This is one of the reasons I want to fix this by making people use
   >either consistent memory or PCI pools (which is consistent memory
   >too).
   
   Please don't limit the API design to PCI ;)
   
When I say "PCI pools" think "struct device pools" because that
will what it will be in the end.

That is Linus's long range plan, everything you see as pci_*
will become dev_*.

So I'm not really limiting the design in any way.
