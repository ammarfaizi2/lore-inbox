Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133009AbRDSTbs>; Thu, 19 Apr 2001 15:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133018AbRDSTbj>; Thu, 19 Apr 2001 15:31:39 -0400
Received: from denise.shiny.it ([194.20.232.1]:31104 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S133009AbRDSTb0>;
	Thu, 19 Apr 2001 15:31:26 -0400
Message-ID: <3ADDDF82.DB37117B@denise.shiny.it>
Date: Wed, 18 Apr 2001 20:40:02 +0200
From: Giuliano Pochini <pochini@denise.shiny.it>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: SodaPop <soda@xirr.com>
CC: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Oscillations in disk write compaction, poor interactive performance
In-Reply-To: <Pine.LNX.4.30.0104170950350.24360-100000@xirr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The problem is that at the low point in the cycle, the machine is
> unusable.  It is utterly unresponsive until the writes complete, which can
> take a very long time (in the case of the ppc machine, several minutes!)
> Anything that does disk I/O will block for a long time - having 'ls' take
> two minutes is not a good thing.

Can you chack how much cpu time do dbflush and kswapd get ?

> 2.2 does not exhibit this behaviour.

2.2 is much worse IMO.

Bye.

