Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317906AbSG0XYY>; Sat, 27 Jul 2002 19:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318858AbSG0XYY>; Sat, 27 Jul 2002 19:24:24 -0400
Received: from holomorphy.com ([66.224.33.161]:60836 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317906AbSG0XYX>;
	Sat, 27 Jul 2002 19:24:23 -0400
Date: Sat, 27 Jul 2002 16:27:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] Re: Serial Oopsen caused by global IRQ chanes
Message-ID: <20020727232725.GQ25038@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Russell King <rmk@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
References: <20020727191119.C32766@flint.arm.linux.org.uk> <Pine.LNX.4.44.0207272034210.19384-100000@localhost.localdomain> <20020727223617.GO25038@holomorphy.com> <20020727230150.GP25038@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020727230150.GP25038@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2002 at 08:43:04PM +0200, Ingo Molnar wrote:
>>> the attached patch fixes a synchronize_irq() bug: if the interrupt is 
>>> freed while an IRQ handler is running (irq state is IRQ_INPROGRESS) then 

In combination with Rusty's hotplug fixes, and your additional diff
atop that, this successfully allows my 16-way to boot.

Let me know if there's anything else you'd like me to test.


Thanks,
Bill
