Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271263AbTGPXS5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 19:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271255AbTGPXRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 19:17:17 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:3743 "EHLO
	genius.impure.org.uk") by vger.kernel.org with ESMTP
	id S271258AbTGPXRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 19:17:08 -0400
Date: Thu, 17 Jul 2003 00:31:24 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PS2 mouse going nuts during cdparanoia session.
Message-ID: <20030716233124.GA16209@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Vojtech Pavlik <vojtech@suse.cz>, Jens Axboe <axboe@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030716165701.GA21896@suse.de> <20030716170352.GJ833@suse.de> <1058375425.6600.42.camel@dhcp22.swansea.linux.org.uk> <20030716171607.GM833@suse.de> <20030716172331.GD21896@suse.de> <20030716190018.GE20241@ucw.cz> <20030716193002.GA2900@suse.de> <20030716205319.GA20760@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716205319.GA20760@ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 10:53:19PM +0200, Vojtech Pavlik wrote:
 > >  > Dave, can you please enable the DEBUG in i8042.c so that I can see
 > >  > whether the bytes really get lost or if the unsync check is just
 > >  > triggering by mistake?
 > > 
 > > Intriguing. With DEBUG enabled, I get a few gig of logs, but
 > > I can't trigger the dancing mouse pointer any more. With it
 > > disabled, I can reproduce it within a minute or two.
 > > 
 > > Seems to be a timing related bug.
 > 
 > Ouch.

Finally managed to recreate it.
http://www.codemonkey.org.uk/cruft/dancingmouse.txt

>From 00:01:33 to 00:01:40 the box was having a fit.
Then things returned to normal.

		Dave

