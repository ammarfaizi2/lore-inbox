Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbTK3Skj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 13:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbTK3Skj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 13:40:39 -0500
Received: from ppp-RAS1-2-109.dialup.eol.ca ([64.56.225.109]:3968 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S262707AbTK3Skh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 13:40:37 -0500
Date: Sun, 30 Nov 2003 13:40:37 -0500
From: William Park <opengeometry@yahoo.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11 -- Failed to open /dev/ttyS0: No such device
Message-ID: <20031130184037.GA294@node1.opengeometry.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031130071757.GA9835@node1.opengeometry.net> <20031130102351.GB10380@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031130102351.GB10380@outpost.ds9a.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 11:23:51AM +0100, bert hubert wrote:
> On Sun, Nov 30, 2003 at 02:17:57AM -0500, William Park wrote:
> > Does anyone have modem working in 2.6.0-test11?
> > 
> > I have external modem connected to /dev/ttyS0 (COM1).  Kernel
> > 2.6.0-test11 give me
> 
> Double check your .config and attach it if in doubt.
> 
> Something like grep SERIAL .config might be enlightning.

My apology...

    CONFIG_PARPORT_SERIAL=m
    # CONFIG_MOUSE_SERIAL is not set
    # CONFIG_SERIAL_NONSTANDARD is not set
    CONFIG_SERIAL_8250=m
    CONFIG_SERIAL_8250_CS=m
    CONFIG_SERIAL_8250_NR_UARTS=4
    # CONFIG_SERIAL_8250_EXTENDED is not set
    CONFIG_SERIAL_CORE=m
    CONFIG_SND_SERIAL_U16550=m
    # CONFIG_USB_SERIAL is not set

    CONFIG_PPP=m
    # CONFIG_PPP_MULTILINK is not set
    # CONFIG_PPP_FILTER is not set
    CONFIG_PPP_ASYNC=m
    CONFIG_PPP_SYNC_TTY=m
    CONFIG_PPP_DEFLATE=m
    CONFIG_PPP_BSDCOMP=m
    CONFIG_PPPOE=m

Everything related to serial and ppp are module.  This is the way I have
it with 2.4.23.  I haven't tried any earlier version than 2.6.0-test11.

-- 
William Park, Open Geometry Consulting, <opengeometry@yahoo.ca>
Linux solution for data management and processing. 
