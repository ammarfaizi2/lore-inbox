Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283468AbRLDUeN>; Tue, 4 Dec 2001 15:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283388AbRLDUdE>; Tue, 4 Dec 2001 15:33:04 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:58328 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S283424AbRLDUck>;
	Tue, 4 Dec 2001 15:32:40 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15373.13022.573204.805366@napali.hpl.hp.com>
Date: Tue, 4 Dec 2001 12:32:30 -0800
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, alan@lxorguk.ukuu.org.uk, arjanv@redhat.com,
        linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org,
        marcelo@conectiva.com.br
Subject: Re: [Linux-ia64] patch to no longer use ia64's software mmu
In-Reply-To: <20011204.122254.110116318.davem@redhat.com>
In-Reply-To: <15371.62205.231945.798891@napali.hpl.hp.com>
	<E16BC09-0001Ql-00@the-village.bc.nu>
	<15372.63827.716885.948119@napali.hpl.hp.com>
	<20011204.122254.110116318.davem@redhat.com>
X-Mailer: VM 6.76 under Emacs 20.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 04 Dec 2001 12:22:54 -0800 (PST), "David S. Miller" <davem@redhat.com> said:

  DaveM> If what you are asking is should we tweak the APIs again so
  DaveM> that situations like current IA64 can be done more sanely in
  DaveM> the PCI DMA layer, I say definitely no.

I certainly agree that the PCI DMA interface shouldn't be tweaked just
because of IA64.  What I'm wondering is whether we'll have to tweak it
anyhow to more gracefully handle the case where a hardware I/O TLB
runs out of space.  If so, I think the software I/O TLB makes sense.

  DaveM> There really is no excuse for the current IA64 hardware
  DaveM> situation, there were probably well over 3 or 4 major 64-bit
  DaveM> platforms from competitors, whose PCI controllers were pretty
  DaveM> well documented publicly, from which Intel could have derived
  DaveM> a working 64-bit platform PCI controller design.

Well, I won't comment on *this* one! ;-))

	--david
