Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131976AbRDJOX0>; Tue, 10 Apr 2001 10:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131979AbRDJOXQ>; Tue, 10 Apr 2001 10:23:16 -0400
Received: from ns.suse.de ([213.95.15.193]:51717 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131976AbRDJOXC>;
	Tue, 10 Apr 2001 10:23:02 -0400
Date: Tue, 10 Apr 2001 16:22:02 +0200
From: Andi Kleen <ak@suse.de>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: David Schleef <ds@schleef.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mark Salisbury <mbs@mc.com>, Jeff Dike <jdike@karaya.com>,
        schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
Message-ID: <20010410162202.A18129@gruyere.muc.suse.de>
In-Reply-To: <20010410053105.B4144@stm.lbl.gov> <Pine.LNX.3.96.1010410155723.28395A-100000@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1010410155723.28395A-100000@artax.karlin.mff.cuni.cz>; from mikulas@artax.karlin.mff.cuni.cz on Tue, Apr 10, 2001 at 04:10:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 04:10:28PM +0200, Mikulas Patocka wrote:
> Timers more precise than 100HZ aren't probably needed - as MIN_RTO is 0.2s
> and MIN_DELACK is 0.04s, TCP would hardly benefit from them.

On networking bandwidth shaping and traffic control generally need higher precision timers.
There are also people who don't like the minimum 10ms delay for non-busy wait, it's
apparently a problem for some apps.

-Andi
