Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274120AbRISRgT>; Wed, 19 Sep 2001 13:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274121AbRISRf7>; Wed, 19 Sep 2001 13:35:59 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:38153 "EHLO
	osdlab.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S274120AbRISRf5>; Wed, 19 Sep 2001 13:35:57 -0400
Message-ID: <3BA8D723.51F17211@osdlab.org>
Date: Wed, 19 Sep 2001 10:34:27 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
CC: Alan <alan@lxorguk.ukuu.org.uk>, crutcher+kernel@datastacks.com,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Magic SysRq +# in 2.4.9-ac/2.4.10-pre12
In-Reply-To: <3BA8C01D.79FBD7C3@osdlab.org> <20010919193105.E7179@arthur.ubicom.tudelft.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:
> 
> On Wed, Sep 19, 2001 at 08:56:13AM -0700, Randy.Dunlap wrote:
> > I have an IBM model KB-9910 keyboard.  When I use
> > Alt+SysRQ+number (number: 0...9) on it to change the
> > console loglevel, only keys 5 and 6 have the desired
> > effect.  I used showkey -s to view the scancodes from
> > the other <number> keys, but showkey didn't display
> > anything for them.  Any other suggestions?
> 
> Same over here with an IBM PS/2 keyboard that originally came with an
> IBM PS2 model 55SX. The IBM keyboard is connected to an Asus M8300
> laptop. The keyboard of that laptop has the interesting "feature" that
> Alt-SysRQ-m sets the loglevel to 0, and Alt-SysRQ-[suob] also set the
> loglevel to a different value instead of doing their job.

I'm having this (my same) problem on a different test system/keyboard,
and I'm beginning to think that it's not a keyboard problem,
but I don't have any evidence of that one way or the other.

I've tested 2.4.2, 2.4.5, 2.4.6, 2.4.7, 2.4.9, and 2.4.10-pre,
and all exhibit the same problem.

~Randy
