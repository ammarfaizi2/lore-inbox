Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263928AbUE3ODf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263928AbUE3ODf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 10:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263932AbUE3ODe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 10:03:34 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:60033 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S263928AbUE3ODd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 10:03:33 -0400
Date: Sun, 30 May 2004 16:03:50 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Eduard Bloch <edi@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
Message-ID: <20040530140350.GA2053@ucw.cz>
References: <xb7r7t2b3mb.fsf@savona.informatik.uni-freiburg.de> <20040530111847.GA1377@ucw.cz> <xb71xl2b0to.fsf@savona.informatik.uni-freiburg.de> <20040530124353.GB1496@ucw.cz> <20040530135445.GA7571@zombie.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040530135445.GA7571@zombie.inka.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 03:54:45PM +0200, Eduard Bloch wrote:

> Moin Vojtech!
>
> Vojtech Pavlik schrieb am Sonntag, den 30. Mai 2004:
> 
> > >     Vojtech> Of course, unless you create a device that can use it,
> > >     Vojtech> but in that case you can easily write a kernel driver for
> > >     Vojtech> it.
> > > 
> > > How about  the PS/2 mouse  port?  It's not  just for mice.   There ARE
> > > implementations using it for other things: touchpad, touchscreen, etc.
> > 
> > All simulate a mouse. Some have somewhat extended protocols, but those
> > protocols are still bound by mouse packet constraints, because the
> > controllers tend to do nasty things to the data passing through, like
> > merging input from multiple devices together into one stream by summing
> > the packets, etc.
> 
> Who says that merging (as it is currently done) is the best way to do?

I definitely don't. But many notebooks do that in hardware.
My point was that it's not always possible to transfer arbitrary data
over the PS/2 port - it's not a general purpose serial port.

> For examle, I wish to create two terminals with my system, using two
> monitors (on dual-head video card), two keyboards and two mices. I can
> do the first part (X manages it well) but not beeing able to use
> different input devices for different users simply SUCKS.
> But http://linuxconsole.sourceforge.net/ lets me hope.

I wrote most of the input handling in that project. It's what is in 2.6 now.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
