Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280883AbRLDQ2D>; Tue, 4 Dec 2001 11:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278932AbRLDQ1x>; Tue, 4 Dec 2001 11:27:53 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:56256 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S278625AbRLDQ1l>;
	Tue, 4 Dec 2001 11:27:41 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15372.63827.716885.948119@napali.hpl.hp.com>
Date: Tue, 4 Dec 2001 08:26:59 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davidm@hpl.hp.com, arjanv@redhat.com (Arjan van de Ven),
        linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org,
        marcelo@conectiva.com.br, davem@redhat.com
Subject: Re: [Linux-ia64] patch to no longer use ia64's software mmu
In-Reply-To: <E16BC09-0001Ql-00@the-village.bc.nu>
In-Reply-To: <15371.62205.231945.798891@napali.hpl.hp.com>
	<E16BC09-0001Ql-00@the-village.bc.nu>
X-Mailer: VM 6.76 under Emacs 20.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 4 Dec 2001 09:36:33 +0000 (GMT), Alan Cox <alan@lxorguk.ukuu.org.uk> said:

  >> Another concern I have is that, fundamentally, I dislike the idea
  >> of penalizing all IA-64 platforms due to one chipset that is,
  >> shall we say, "lacking" (i.e., doesn't have an I/O TLB).

  Alan> Allow me to introduce to you the concept of CONFIG_ options 8)
  Alan> It makes a lot of sense to have a generic IA64 kernel, and an
  Alan> IA64 designed by people with a brain kernel.

I think the issue at hand is whether, longer term, it is desirable to
move all bounce buffer handling into the PCI DMA layer or whether
Linux should continue to make bounce buffer management visible to
drivers.  I'd be interested in hearing opinions.

	--david
