Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265786AbRGEPrB>; Thu, 5 Jul 2001 11:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265783AbRGEPqv>; Thu, 5 Jul 2001 11:46:51 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:50766 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265799AbRGEPqj>; Thu, 5 Jul 2001 11:46:39 -0400
Date: Thu, 5 Jul 2001 11:46:33 -0400
From: Arjan van de Ven <arjanv@redhat.com>
To: Thibaut Laurent <thibaut@celestix.com>
Cc: Andrea Arcangeli <andrea@suse.de>, arjanv@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
Message-ID: <20010705114633.A1787@devserv.devel.redhat.com>
In-Reply-To: <20010704232816.B590@marvin.mahowi.de> <20010705162035.Q17051@athlon.random> <3B447B6D.C83E5FB9@redhat.com> <20010705164046.S17051@athlon.random> <20010705233200.7ead91d5.thibaut@celestix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010705233200.7ead91d5.thibaut@celestix.com>; from thibaut@celestix.com on Thu, Jul 05, 2001 at 11:32:00PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2001 at 11:32:00PM +0800, Thibaut Laurent wrote:
> And the winner is... Andrea. Kudos to you, I've just applied these patches,
> recompiled and it seems to work fine.
> Too bad, this was the perfect excuse for getting rid of those good old Cyrix
> boxen ;)

As Andrea's patches don't actually fix anything Cyrix related it's obvious
that they just avoid the real bug instead of fixing it.
It's a very useful datapoint though.
