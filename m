Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266702AbTBPN1g>; Sun, 16 Feb 2003 08:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266755AbTBPN1g>; Sun, 16 Feb 2003 08:27:36 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:59780 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S266702AbTBPN1f>; Sun, 16 Feb 2003 08:27:35 -0500
From: David Woodhouse <dwmw2@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <1045404715.16464.8.camel@irongate.swansea.linux.org.uk>
References: <E18k81g-0007KU-00@the-village.bc.nu>
	 <1045390711.2068.44.camel@imladris.demon.co.uk>
	 <1045404715.16464.8.camel@irongate.swansea.linux.org.uk>
Organization: 
Message-Id: <1045402648.2068.179.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 16 Feb 2003 13:37:28 +0000
Subject: Re: PATCH: header update for arcnet updates (again to match 2.4)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-02-16 at 14:11, Alan Cox wrote:
> On the 20020 ?

On the ISA COM20020 eval boards from SMC, yes -- that's what my addled
brain seems to recall, and I'm inclined to believe it this time because
com20020.c::com20020_found() still has the following:

        if (!dev->dev_addr[0])
                dev->dev_addr[0] = inb(ioaddr + 8);     /* FIXME: do this some other way! */

-- 
dwmw2

