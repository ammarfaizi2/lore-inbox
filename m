Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261337AbRELXCJ>; Sat, 12 May 2001 19:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261336AbRELXB7>; Sat, 12 May 2001 19:01:59 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:20499 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261334AbRELXBr>; Sat, 12 May 2001 19:01:47 -0400
Subject: Re: How can I help with VIA MVP3 problems?
To: plr@udgaard.com (Peter Rasmussen (udgaard))
Date: Sat, 12 May 2001 23:58:01 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, plr@udgaard.com
In-Reply-To: <200105121737.TAA09893@udgaard.com> from "Peter Rasmussen (udgaard)" at May 12, 2001 07:37:23 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14yiKn-0004a2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have done some tests and my conclusion of the tests below is that there 
> is an odd slowdown when compiling kernels, but not anything measurable when 
> runnig Livid OMS. As Alan says my VIA MVP3 chipset is older and shouldn't have
> the previosuly mentioned problems.
> 
> real    11m22.448s
> user    10m39.480s
> sys     0m42.700s
> 
> MemShared:           0 kB  <---- Why is this zero? Is it a problem?

No just no longer accounted.

> The same for compiling the exact same 2.4.4-ac8 kernel while running 2.2.16
> real    8m26.279s
> user    7m8.630s
> sys     0m39.260s

And the config looks sane. Yep I'd say thats the VM balancing problems

Alan

