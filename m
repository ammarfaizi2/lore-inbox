Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271833AbTGYABe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 20:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271832AbTGYABe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 20:01:34 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:26307 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S271833AbTGYABa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 20:01:30 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Vojtech Pavlik <vojtech@suse.cz>
Date: Fri, 25 Jul 2003 02:16:25 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: touchpad doesn't work under 2.6.0-test1-ac2
Cc: schierlm@gmx.de, linux-kernel@vger.kernel.org, pavel@suse.cz
X-mailer: Pegasus Mail v3.50
Message-ID: <82F70261D3A@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Jul 03 at 2:11, Vojtech Pavlik wrote:
> On Fri, Jul 25, 2003 at 12:57:45AM +0200, Pavel Machek wrote:
> > 
> > > This all happens on Compaq EVO N800C. I strongly believe that we need a
> > > build time option for disabling Synaptics detection, or at least input_synaptics=0
> > > runtime option, until it can work at least as well as it works like ps/2
> > > device.
> > 
> > Agreed, I even send a patch to vojtech, he said he is going to apply
> > it and I have not heard about that patch after that...
> 
> For proper Synaptics support an XFree86 driver is available (get it at
> http://w1.894.telia.com/~u89404340/touchpad/index.html). This will allow
> for full support, including gesture recongition. Passthrough support for

I do not use XFree. I'm using 1600x1200 radeonfb consoles.

> enabling the touchpoint or external mice chained to the Synaptics pad is
> pending in my patch queue and will be merged as soon as I return from
> Ottawa.
> 
> Support for touchpads is nonexistent in mousedev.c, it only supports
> mice, digitizers and touchscreens. Just adding an entry to the device
> table is futile, you'd need much much more than that.

What's difference between touchscreen and touchpad? Both use absolute
directions, and rest are just buttons... As I need working gpm, without 
mousedev support Synaptics mode is of no use for me.
                                                            Petr
                                                            

