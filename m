Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262417AbVADXVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262417AbVADXVh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 18:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVADXNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 18:13:47 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:32182 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262378AbVADXLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 18:11:00 -0500
Subject: Re: starting with 2.7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Felipe Alfaro Solana <lkml@mac.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>, Rik van Riel <riel@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@debian.org>
In-Reply-To: <B470A11D-5E5C-11D9-A816-000D9352858E@mac.com>
References: <200501041327.j04DRhfQ007850@laptop11.inf.utfsm.cl>
	 <B470A11D-5E5C-11D9-A816-000D9352858E@mac.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104858355.17176.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 04 Jan 2005 22:04:03 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-01-04 at 14:27, Felipe Alfaro Solana wrote:
> >> Gosh! I bought an ATI video card, I bought a VMware license, etc.... I
> >> want to keep using them. Changing a "stable" kernel will continuously
> >> annoy users and vendors.

I downloaded the DRI drivers (test R300 code in CVS), qemu and Xen 8)

> I can see no easy solution for this... If Linus decides to fork off 
> 2.7, development efforts will go into 2.7 and fixes should get 
> backported to 2.6. If Linus decides to stay with 2.6, new development 
> will have to be "conservative" enough not to break things that were 
> working.

Its relatively easy to fix in kernel drivers for API changes during a
release cycle and it helps enormously being able to do so.
remap_page_range was rapidly fixed and very soon can vanish forever from
the tree.

Alan

