Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281416AbRLDQ6z>; Tue, 4 Dec 2001 11:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281228AbRLDQ5f>; Tue, 4 Dec 2001 11:57:35 -0500
Received: from mail022.mail.bellsouth.net ([205.152.58.62]:33334 "EHLO
	imf22bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S279783AbRLDQz5>; Tue, 4 Dec 2001 11:55:57 -0500
Message-ID: <3C0D0014.DE548F9A@mandrakesoft.com>
Date: Tue, 04 Dec 2001 11:55:49 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
CC: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: OSS driver cleanups.
In-Reply-To: <Pine.LNX.4.33.0112031105230.28692-100000@netfinity.realnet.co.sz> <3C0C1510.DBDA6146@mandrakesoft.com> <20011204164943.D28839@kushida.jlokier.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> 
> Jeff Garzik wrote:
> > I'm sure people will continue using the OSS drivers even after they
> > become the "old" sound drivers... for a while at least.
> 
> Not least because I have reports from my housemate that ALSA drivers are
> a b*tch to set up.  To be done only if there isn't an OSS driver for
> your card.  Whereis with OSS you just load a module and its done.

If "modprobe snd-card-via686" doesn't just-work that is a regression
from 2.4 and thus a bug.  There should be no alsa-conf or anything else
required for these drivers to work.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

