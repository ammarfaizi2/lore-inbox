Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265830AbRGGQoG>; Sat, 7 Jul 2001 12:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265193AbRGGQn4>; Sat, 7 Jul 2001 12:43:56 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:3481 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S264582AbRGGQnr>; Sat, 7 Jul 2001 12:43:47 -0400
Date: Sat, 7 Jul 2001 17:43:45 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: 2.4.6 PCMCIA NET modular build breakage
Message-ID: <20010707174345.C11074@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0107071520250.1054-100000@vaio> <200107071430.f67EUXq07488@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200107071430.f67EUXq07488@linuxhacker.ru>; from green@linuxhacker.ru on Sat, Jul 07, 2001 at 06:30:33PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2001 at 06:30:33PM +0400, Oleg Drokin wrote:
> Hmm....
> (examining Makefile...)
> I see. So there cannot be usual targets before including Rules.make,
> and my copy of the tree have these. And if I move them after inclusion,
> everything builds just fine.
> Perhaps it should be documented somewhere.
> 
> Well. So at the end it seems to be not a vanilla kernel problem. That's good.

Ok, so you got the problem solved.  Mind enlightening me and Nico so we
know what's wrong please?

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

