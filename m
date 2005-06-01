Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVFAVrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVFAVrE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 17:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVFAVqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 17:46:14 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:7971
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261312AbVFAVje
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 17:39:34 -0400
Date: Wed, 1 Jun 2005 23:39:21 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Nicolas Pitre <nico@cam.org>
Cc: Bill Huey <bhuey@lnxw.com>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Karim Yaghmour <karim@opersys.com>, Ingo Molnar <mingo@elte.hu>,
       Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050601213921.GF5413@g5.random>
References: <20050601192224.GV5413@g5.random> <Pine.OSF.4.05.10506012129460.1707-100000@da410.phys.au.dk> <20050601195905.GX5413@g5.random> <20050601201754.GA27795@nietzsche.lynx.com> <20050601203212.GZ5413@g5.random> <20050601204612.GA27934@nietzsche.lynx.com> <20050601210716.GB5413@g5.random> <Pine.LNX.4.63.0506011724310.17354@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0506011724310.17354@localhost.localdomain>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 05:29:48PM -0400, Nicolas Pitre wrote:
> Actualy it's RTAI/rtlinux which is broken wrt the above IRQ disable.
> See for yourself when they're used and watch RTAI/rtlinux crash.  

Well it's not so clear so please elaborate since I'm curious. Especially
it'd be interesting to know if this is that an arm specific kernel
crash, or would it happen on x86 too?

There sure can be arch dependencies where an hard_local_irq_disable can
be necessary in some places, but that's quite a separate topic, and on
x86 I don't see why it should crash.

Thanks.
