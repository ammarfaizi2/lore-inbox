Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270880AbRHNWXg>; Tue, 14 Aug 2001 18:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270901AbRHNWXQ>; Tue, 14 Aug 2001 18:23:16 -0400
Received: from itvu-63-210-168-13.intervu.net ([63.210.168.13]:7307 "EHLO
	pga.intervu.net") by vger.kernel.org with ESMTP id <S270880AbRHNWXI>;
	Tue, 14 Aug 2001 18:23:08 -0400
Message-ID: <3B79A68A.221310D@randomlogic.com>
Date: Tue, 14 Aug 2001 15:30:34 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Are we going too fast?
In-Reply-To: <E15Wdc6-00016N-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> >       - use the uhci USB driver when I'm using a USB printer.  If I
> >         use the usb-uhci driver with my USB printer, the whole system
> >         locks.  This has been reported a few times on LKML,
> >         linux-usb-users, and linux-usb-developers and nobody helped,
> >         but a few people wrote back with "me too"s.  It was broken in
> >         the trasnition from 2.4.3 to 2.4.4 and only seems to affect
> >         SMP systems.  I just gave up on USB printing and went back to
> >         my parallel port.
> 
> usb-uhci seems to not be SMP safe. Ultimately we don't need both uhci
> drivers so that hasnt been one that worried me.  Probably we should drop
> the other uhci driver over time (2.5 maybe)
> 

When I first installed RH 7.1 on my Tyan K7, the system would lock upon boot when the USB module was loaded. I disabled the USB controller in the BIOS and all
was fine. After compiling 2.4.7-ac10 and running it for some time reliably, I re-enabled USB and re-compiled making sure the USB modules were included. They now
load just fine.

Note that I do not (yet) have any USB devices.

PGA
-- 
Paul G. Allen
UNIX Admin II/Programmer
Akamai Technologies, Inc.
www.akamai.com
Work: (858)909-3630
Cell: (858)395-5043
