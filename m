Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTDQMQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 08:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbTDQMQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 08:16:28 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:59088 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261326AbTDQMQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 08:16:26 -0400
Date: Thu, 17 Apr 2003 13:27:49 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Greg KH <greg@kroah.com>
Cc: jsimmons@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: vesa fb in -bk gives too many console lines
Message-ID: <20030417122748.GA20825@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Greg KH <greg@kroah.com>, jsimmons@infradead.org,
	linux-kernel@vger.kernel.org
References: <20030417062546.GA3114@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030417062546.GA3114@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 11:25:46PM -0700, Greg KH wrote:

 > In the latest -bk tree, using the vesa fb driver, I get a window that is
 > much too big for my screen.  I'm using "vga=0x0305" as a command line
 > option, which I've been using for years on this box, and when the fb
 > code kicks in, it creates a screen that has more lines than are
 > displayed on the monitor (text lines that is).  I can see 48 lines, but
 > it's acting like there are more that that present.
 > 
 > Is this just an operator error, in that I need to provide a different
 > command line option now for the size of the console screen?

I've seen this happen too, and a box that worked fine with vga=791
before now gets me a screen full of garbage. I think something got
broken somewhere along the lines.

 > Here's the relevant portions of the boot messages:

<snip zillions of EDID junk>

 > p.s. nice boot messages, I know now that the usb code will stop taking
 > the heat for abusing the kernel log :)

That is in the 'taking the piss' category for voluminous output.
I hope its planned to be quitened down somewhat when we get closer to 2.6.
AIUI, there are userspace tools that dump all that info anyway for
interested parties.

		Dave

