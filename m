Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271817AbRICU6T>; Mon, 3 Sep 2001 16:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271820AbRICU6B>; Mon, 3 Sep 2001 16:58:01 -0400
Received: from bzq-128-3.bezeqint.net ([212.179.127.3]:51467 "HELO arava.co.il")
	by vger.kernel.org with SMTP id <S271817AbRICU5n>;
	Mon, 3 Sep 2001 16:57:43 -0400
Date: Mon, 3 Sep 2001 23:57:50 +0300 (IDT)
From: Matan Ziv-Av <matan@svgalib.org>
To: Simon Hay <simon@haywired.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Multiple monitors
In-Reply-To: <3B93CF91.A6D59DA8@haywired.org>
Message-ID: <Pine.LNX.4.21_heb2.09.0109032353030.2435-100000@matan.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Sep 2001, Simon Hay wrote:

> Hi all,
> 
> Apologies in advance if this is a question that's already been answered
> somewhere...I'm looking for a way to install multiple (or rather, two)
> PCI/AGP cards in a machine and connect a monitor to each one, and use
> them both *in console mode* - preferably with some nice way to say
> 'assign virtual console 2 to the first screen, and 5 to the second' -
> that way you could have one tailing log files, showing 'top', whatever.
> A quick search of the web/newsgroups turned up various patches that
> looked ideal, but a closer inspection revealed that they either relied
> on you having a Hercules mono card, or only applied against kernel
> <0.99, or both...I was just wondering if anyone's thought
> about/written a similar patch for more recent hardware/versions?I was
> using a console Linux machine running BB (ASCII art demo -
> http://aa-project.sourceforge.net/) just to attract attention to our
> stand today and was thinking it would be really neat to have one machine
> driving several screens...

If you want only textmode, look at nvvgacon
http://www.arava.co.il/matan/misc/
this module enables text console on secondary nvidia cards. I think it
only works on riva128 now, but it should be easy to add support for tnt
and later. If you also want to use a second keyboard, There is also
ps2key, usb2key, to emulate a second console (from user space) with a
keyboard connected to usb or to ps/2 mouse port.


-- 
Matan Ziv-Av.                         matan@svgalib.org


