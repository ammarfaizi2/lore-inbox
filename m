Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbTBXXP3>; Mon, 24 Feb 2003 18:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbTBXXP3>; Mon, 24 Feb 2003 18:15:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14853 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262469AbTBXXP2>; Mon, 24 Feb 2003 18:15:28 -0500
Date: Mon, 24 Feb 2003 15:20:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andreas Schwab <schwab@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
In-Reply-To: <1046132400.2216.0.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0302241519520.19762-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 25 Feb 2003, Alan Cox wrote:
> On Mon, 2003-02-24 at 22:39, Linus Torvalds wrote:
> > And yes, gcc could do the work necessary to only give the warning if it 
> > actually has reason to believe that the code is wrong. As it is, it gives 
> > the warning for code that is good.
> 
> gcc gives the warning only when you ask it to annoy you. Seems a good trade off.

That _used_ to be true.

Look at the subject line. gcc-3.3 gives the warning for -Wall.

			Linus

