Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbTDKUUz (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 16:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTDKUUz (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 16:20:55 -0400
Received: from windsormachine.com ([206.48.122.28]:26116 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S261754AbTDKUUy (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 16:20:54 -0400
Date: Fri, 11 Apr 2003 16:32:06 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: Chris Hanson <cph@zurich.ai.mit.edu>
cc: John Bradford <john@grabjohn.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       <linux-kernel@vger.kernel.org>,
       <linux-hotplug-devel@lists.sourceforge.net>
Subject: Re: [ANNOUNCE] udev 0.1 release
In-Reply-To: <E19453q-0004gk-00@nuwen.ai.mit.edu>
Message-ID: <Pine.LNX.4.33.0304111628160.14943-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Apr 2003, Chris Hanson wrote:

> Using a tree (what you are calling massively parallel) for
> distribution produces a uniform voltage drop for all of the devices,
> and has a better worst-case voltage drop than a serial chaining
> distribution.  The serial chain has different voltage drops for each
> pair of disks, depending on how far down the chain they are, but the
> worst case is very bad.
>

I do wonder how we're going to run the 46KW of power (Assuming these
drives pull similar to the drive i just checked) down the line.

Should we use solid copper bars in a bus setup?  You'll be pulling 2000
amps off the 5v, and 3000 off the 12V.  We may wish to rethink the method
of hooking up our 46000 watt power supply.  I suspect a bus may be a
better way, and probably easier to setup and maintain.

And much more fun when you drop a screwdriver across it.

Mike

