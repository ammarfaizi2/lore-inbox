Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267758AbUBTJ2D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 04:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267748AbUBTJ2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 04:28:03 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24849 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267760AbUBTJ16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 04:27:58 -0500
Date: Fri, 20 Feb 2004 09:27:52 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>, dsaxena@plexity.net,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB update for 2.6.3
Message-ID: <20040220092752.C22235@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Brownell <david-b@pacbell.net>, dsaxena@plexity.net,
	Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux-USB <linux-usb-devel@lists.sourceforge.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040220012802.GA16523@kroah.com> <Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org> <1077256996.20789.1091.camel@gaston> <20040220074041.GA6680@plexity.net> <1077263253.20789.1221.camel@gaston> <20040220080801.GA6786@plexity.net> <4035C8C4.8010605@pacbell.net> <1077266892.20779.1290.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1077266892.20779.1290.camel@gaston>; from benh@kernel.crashing.org on Fri, Feb 20, 2004 at 07:48:13PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20, 2004 at 07:48:13PM +1100, Benjamin Herrenschmidt wrote:
> Anyway, a platform hook in device_add() seem like it could be
> useful for other things as well...

What about platform_notify() which already seems to be provided for you ?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
