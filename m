Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292918AbSB0WlY>; Wed, 27 Feb 2002 17:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292958AbSB0Wkn>; Wed, 27 Feb 2002 17:40:43 -0500
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:27162 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S293022AbSB0WkS>; Wed, 27 Feb 2002 17:40:18 -0500
Message-ID: <3C7D6266.CFFDC7A3@mindspring.com>
Date: Wed, 27 Feb 2002 14:49:10 -0800
From: Joe <joeja@mindspring.com>
Reply-To: joeja@mindspring.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.18 and RH 7.2
In-Reply-To: <E16gBMx-0005rt-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately it is not just warnings.  It does not allow the firewall /
packet filter to start and iptables -L shows an open system as the rules were
never applied.  Needless to say I'm back on 2.4.17.

Maybe I should file this as a bug with RH 7.2 then......

> > iptables 1.2.4 was rebuild for the 2.4.17 because it stopped working at
> > that point.  I hope it isn't requirement to rebuild iptables against each
> > stable kernel release.
>
> Its not a requirement for 1.2.4 and 2.4.18 either - what happened was that
> some people (Red Hat notably) turned all the paranoid debugging stuff on
> and that is what spews the warnings.

