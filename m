Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273691AbRJDLQc>; Thu, 4 Oct 2001 07:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273724AbRJDLQV>; Thu, 4 Oct 2001 07:16:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:54939 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S273691AbRJDLQP>;
	Thu, 4 Oct 2001 07:16:15 -0400
Date: Thu, 04 Oct 2001 04:16:04 -0700 (PDT)
Message-Id: <20011004.041604.13771259.davem@redhat.com>
To: balbir.singh@wipro.com
Cc: James.Bottomley@HansenPartnership.com, jes@sunsite.dk,
        linuxopinion@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: how to get virtual address from dma address
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BBC35BC.5020706@wipro.com>
In-Reply-To: <200110032244.f93MiI103485@localhost.localdomain>
	<20011003.172439.66056954.davem@redhat.com>
	<3BBC35BC.5020706@wipro.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "BALBIR SINGH" <balbir.singh@wipro.com>
   Date: Thu, 04 Oct 2001 15:41:08 +0530

   With Rik's reverse mapping patch, wouldn't we have the virtual address for the given
   physical address ? I have no clue about how the patch works, somebody willing to explain
   it?
   
Rik's work is for user process PTEs, we're talking about IOMMU PTEs on
PCI controllers used to map the 32-bit PCI address space to the (often
larger) physical address space of main memory.

These two PTE types are totally unrelated.

Franks a lot,
David S. Miller
davem@redhat.com
