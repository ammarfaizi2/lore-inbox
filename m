Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbUJZPdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbUJZPdn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 11:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbUJZPdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 11:33:43 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:50445 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262301AbUJZPbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 11:31:14 -0400
Message-ID: <417E70D2.2010302@techsource.com>
Date: Tue, 26 Oct 2004 11:44:18 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: pbecke <pbecke@javagear.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <6.1.2.0.1.20041026082223.0231edd8@mail.javagear.com>
In-Reply-To: <6.1.2.0.1.20041026082223.0231edd8@mail.javagear.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



pbecke wrote:
> As a developer, who has been struggling with displaying HDTV using off 
> the shelf cards, I am intrigued by an open source video card.  Since my 
> primary goal is to display HDTV, my primary need is 2D.  Support for 
> Nvidia and ATI exist, however I still run into problems. For example I 
> have been totally unable to display 1080I using a digital interface with 
> either vendors card.  Even with an analog interface, it is next to 
> impossible to reliable synchronize the top and bottom display field, 
> with the top and bottom field of an interlace stream.  I am sure the 
> information must exists on the card somewhere to determine the field 
> being displayed, but I am unable to access it because of lack of 
> documentation.

We'll have to be sure to include a way to access that information.

> 
> In general an open source video card is a great idea, however, I am a 
> bit concerned about your plans to keep the FPGA code secret.  I realize 
> that your company wants to make a profit, 

And that is the POINT here.  The question isn't whether or not we can 
become a charity and give away all of our IP.  The question is whether 
or not it's possible to sell open-source-friendly products.  Designing 
and manufacturing hardware is EXPENSIVE.  Especially at the volumes I 
expect.

> but in keeping with the spirit 
> of open source, it seems that it would be a good idea to not only open 
> up the driver development, but also to open up the FPGA code.  The great 
> power of open source is that it allows a developer to tweak the 
> implementation.

What you're asking for is excessive.  Even Stallman agrees that people 
should be able to profit from their work.  Opening the source to this 
chip would be good for you and for every other company that wants to 
copy it, but it would not be good for Tech Source.  Tech Source is a 
business with a profit motive.  Will will not engage in something that 
costs us more money than it makes or diverts us from something more 
profitable.

You're allowing your lofty free software ideals to get in the way of 
what is reasonable and practical.  I believe in freedom, which is why I 
started this project.  But make no mistake in thinking that I'm trying 
to waste the time and money of my employer.

The only thing you need to make this product work is the software 
information necessary to communicate with it.  Hardware is not free, and 
it never will be.  Software, on the other hand, is trivially easy to 
copy.  So let's let the software be free.

Also do not make the mistake of believing that software is free to 
PRODUCE.  If it were, then free software fans wouldn't love the GPL 
which protects their investment of time from being ripped off by greedy 
companies that would like to steal their work.  Tech Source would have 
to factor my time to develop software for this product into the final 
price that you pay for the hardware.  The advantage you have is that the 
software, being open source, is guaranteed to outlive you, me, and 
everyone else.

> Additionally for this reason, I also think it should be possible to 
> dynamically load the FPGA without having to power down or reset.  One 
> could easily imagine a card where the boot loader loads a simple VGA 
> interface, but then upon switching to X, a more sophisticated and 
> powerful interface could be loaded.  This takes advantage of the 
> reprogram ability of an FPGA, while making the device useful to both the 
> low end embedded needs as well as the high end gamers.

If you only have one FPGA on the board, then you have a chicken and egg 
problem.  It's programmed through JTAG which turns the entire chip into 
a giant shift register.  The moment you start programming it, all 
variable logic stops working.

> In fact it may make the most sense for a company like Xilinx to provide 
> support for such a development, since ultimately, Xilinx is the company 
> that will profit the most by selling more chips.  Does anyone know a 
> contact at Xilinx who would be open to such a request?

Xilinx already supplies free tools, and they also supply instructions 
for getting their tools to work with WINE.

> Perhaps, rather than a single company defining the functionality with 
> input from the open source community, it makes more sense for the open 
> source community to define the standard, and then any company could work 
> from the standard created by the open source community.

As I've said before, if people want to give us a design, we'll 
manufacture it!

> The problem isn't so much that the vendors don't provide proper data 
> sheets, as it is that there is no open standard for extended registers 
> and advanced interfaces on graphics cards.  Imagine if USB and IEEE 1394 
> and Ethernet  where closed standards.  We would all be trying to reverse 
> engineer M$ drivers, or we would have to rely on the buggy closed source 
> drivers that the vendors decide to throw our way, with the only 
> alternative of using a slow open source RS232 interface.  That is 
> essentially what has happened in the realm of graphics cards.

Different chips do things in different ways.  I guarantee you that my 
video controller design will be quite alien to you.  It'll also be one 
of the most programmable you've ever encountered.

> If the open source community leads, others will follow.

If you participate in a project that produces something that I can put 
into a chip, let me know.

