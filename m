Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290491AbSAYBvW>; Thu, 24 Jan 2002 20:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290492AbSAYBvM>; Thu, 24 Jan 2002 20:51:12 -0500
Received: from adsl-64-166-42-58.dsl.scrm01.pacbell.net ([64.166.42.58]:35847
	"EHLO tim.plush.org") by vger.kernel.org with ESMTP
	id <S290491AbSAYBu4>; Thu, 24 Jan 2002 20:50:56 -0500
Date: Thu, 24 Jan 2002 17:50:52 -0800
To: Brian Lavender <brian@brie.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VAIO IRQ assignment problem of USB controller
Message-ID: <20020125015052.GA2153@foo.plush.org>
Mail-Followup-To: grosa, Brian Lavender <brian@brie.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020124173421.B8732@brie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020124173421.B8732@brie.com>
User-Agent: Mutt/1.3.25i
From: Gabriel Rosa <grosa@plush.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Jan 24, 2002 at 05:34:21PM -0800, Brian Lavender wrote:
> I have a Sony VAIO PCG-GR170K laptop with a memory stick which operates
> off of the USB controller with device ID 00:1d.2. The laptop has a total
> of three USB controllers.  The first two are getting IRQ's, but the third
> one is not. Under Win2k, it assigns all three USB controllers IRQ 9. I
> checked the bios for USB options, and the only option I could find is to
> set a "Non PNP" OS.  I found no other USB options. I am currently using
> kernel 2.4.9 from Redhat compiled from the source RPM.  I am guessing
> that this must be a problem somewhere in the PCI IRQ configuration.
> Any other suggestions aside from downloading 2.4.17?
> 
[snip]

Hey Brian,

the mem stick + 2 usb ports my Z505LS work fine with 2.4.16+
(both usb ports have been tested, but the mem stick not [however, it shows
up fine at boot time]).

You might also want to run 2.4.teen because of the new support for the
Sony programmable controller (althought that seems to have gone into 2.4.5)
(under char devices, i believe).

See: http://groups.google.com/groups?q=linux+sony+programmable+controller&hl=en&selm=linux.kernel.20010604153515.A31991%40ontario.alcove-fr&rnum=1

I think I told you about the GVaioControl app that I use for brightness at the
big installfest over the summer, but this seems to actually enable the function
keys.

-Gabe

ps. heh, it's weird seeing people you know on LK :)
