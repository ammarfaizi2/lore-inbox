Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132864AbRDIWcJ>; Mon, 9 Apr 2001 18:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132865AbRDIWcA>; Mon, 9 Apr 2001 18:32:00 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:10502 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S132864AbRDIWbp>; Mon, 9 Apr 2001 18:31:45 -0400
Date: Tue, 10 Apr 2001 00:31:08 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Mark Salisbury <mbs@mc.com>, Jeff Dike <jdike@karaya.com>,
        schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
In-Reply-To: <E14mi1M-0002pU-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1010410002852.4212A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > this is one of linux biggest weaknesses.  the fixed interval timer is a
> > throwback.  it should be replaced with a variable interval timer with interrupts
> > on demand for any system with a cpu sane/modern enough to have an on-chip
> > interrupting decrementer.  (i.e just about any modern chip)
> 
> Its worth doing even on the ancient x86 boards with the PIT.

Note that programming the PIT is sloooooooow and doing it on every timer
add_timer/del_timer would be a pain.

Mikulas

