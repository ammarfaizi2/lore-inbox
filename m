Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbTI0RWg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 13:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbTI0RWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 13:22:36 -0400
Received: from eva.fit.vutbr.cz ([147.229.10.14]:23816 "EHLO eva.fit.vutbr.cz")
	by vger.kernel.org with ESMTP id S262570AbTI0RWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 13:22:34 -0400
Date: Sat, 27 Sep 2003 19:22:30 +0200
From: David Jez <dave.jez@seznam.cz>
To: Piotr =?iso-8859-2?Q?Szyma=F1ski?= <djurban@gnu.univ.gda.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: urb timeouts with eagle on 2.4.20
Message-ID: <20030927172230.GA83627@stud.fit.vutbr.cz>
References: <200309271643.25235.djurban@gnu.univ.gda.pl> <20030927151736.GA81700@stud.fit.vutbr.cz> <200309271748.04950.djurban@gnu.univ.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200309271748.04950.djurban@gnu.univ.gda.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 27, 2003 at 05:50:40PM +0200, Piotr Szymañski wrote:
> Hi,
> On Saturday 27 of September 2003 17:17, David Jez wrote:
> >   lspci -v
> 00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00 
> [UHCI])
> Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
> Flags: bus master, medium devsel, latency 32, IRQ 7
> I/O ports at c400 [size=32]
> Capabilities: [80] Power Management version 2
> 
> >   Ofcourse, you can use powertweak utility too.
> Cool, thanks for the tip, last thing remaining (maybe you know thisas well), 
> what value should I to set it to?
  less value is less latency, you can try 0 instead of 32. But if via
has got any problem with their HW which is workarounded in m$win...
maybe this will not help you :*(

> >   hmm, this sound interesting. So, did you tried use uhci usb adapter
> > instead of usb-uhci? Maybe it will works better.
> Ive been using it all the time.
  And what about other USB devices? e.g. USB flash disks works fine?

> -- 
> Piotr Szymañski
> djurban@gnu.univ.gda.pl; djurban.jogger.pl
> JID: djurban@jabber.org; GG 2300264; ICQ: 12622400
-- 
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@eva.fit.vutbr.cz
---------=[ ~EOF ]=------------------------------------
