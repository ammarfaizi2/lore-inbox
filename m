Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbTJABZH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 21:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbTJABZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 21:25:07 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:43905
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261856AbTJABZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 21:25:02 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: Keyboard dead on bootup on -test6.
Date: Tue, 30 Sep 2003 20:21:56 -0500
User-Agent: KMail/1.5
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <200309301632.01498.rob@landley.net> <20031001005214.GC1520@win.tue.nl>
In-Reply-To: <20031001005214.GC1520@win.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309302021.56614.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 September 2003 19:52, Andries Brouwer wrote:
> On Tue, Sep 30, 2003 at 04:32:01PM -0500, Rob Landley wrote:
> > This was the failure:
> >
> > Sep 30 16:17:31 localhost kernel: atkbd.c: Unknown key pressed (raw set
> > 0, code 0xfc, data 0xfc, on isa0060/serio1).
> > Sep 30 16:17:31 localhost kernel: serio: i8042 AUX port at 0x60,0x64 irq
> > 12 Sep 30 16:17:31 localhost kernel: serio: i8042 KBD port at 0x60,0x64
> > irq 1
> >
> > Under -test5, that failure would have left me with a stuck key endlessly
> > repeating (and an otherwise dead keyboard).  Now at least the stuck key
> > part has gone away, but the keyboard is still dead until I power cycle
> > the machine.
>
> I suppose this is the kernel trying to set LEDs on the mouse,
> and the mouse complains.
>
> Andries

It's a laptop nipple mouse, a miniature joystick between the G and H keys.  
There are no LED's anywhere near it.  So I'm not surprised it complains.  But 
why does that kill my keyboard?  (You'll notice that the keyboard 
identification line goes missing when this error occurs...)

Rob
