Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264297AbUE2OgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264297AbUE2OgT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 10:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264937AbUE2OgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 10:36:18 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:43140 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264297AbUE2OgL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 10:36:11 -0400
Date: Sat, 29 May 2004 16:36:30 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/44] Support for scroll wheel on Office keyboards
Message-ID: <20040529143630.GA15136@ucw.cz>
References: <1079446776784@twilight.ucw.cz> <10794467761141@twilight.ucw.cz> <20040327195535.GA11610@wsdw14.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040327195535.GA11610@wsdw14.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2004 at 08:55:35PM +0100, Andries Brouwer wrote:
> On Tue, Mar 16, 2004 at 03:19:36PM +0100, Vojtech Pavlik wrote:
> 
> >   input: Add support for scroll wheel on MS Office and similar keyboards.
> 
> > +static unsigned char atkbd_scroll_keys[5][2] = {
> > +	{ ATKBD_SCR_1,     0x45 },
> > +	{ ATKBD_SCR_2,     0x29 },
> > +	{ ATKBD_SCR_4,     0x36 },
> > +	{ ATKBD_SCR_8,     0x27 },
> > +	{ ATKBD_SCR_CLICK, 0x60 },
> > +};
> 
> Hi Vojtech,
> 
> Can you tell me what keyboard model uses these codes?
> (I have different codes for the scroll wheel on certain MS Office
> keyboards. See also somewhere below
> http://www.win.tue.nl/~aeb/linux/kbd/scancodes-5.html#ss5.4 )

The above codes are completely wrong. I don't know how I figured them
out, nevertheless, my current tree has them fixed, and they correspond
to your scancode table.

> Apart from this concrete question - the number of keyboards and
> mice is very large and growing by the day. I think it is hopeless
> to try and teach the kernel about all details of each of them.
> I think we should try to go for a keyboard/mouse definition file
> maintained in user space and fed to the kernel.
 
That's the plan. But you can't describe the scrollwheel functionality
there.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
