Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbULaSSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbULaSSu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 13:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbULaSSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 13:18:50 -0500
Received: from dialin-163-34.tor.primus.ca ([216.254.163.34]:12928 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S262132AbULaSSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 13:18:48 -0500
Date: Fri, 31 Dec 2004 13:18:36 -0500
From: William Park <opengeometry@yahoo.ca>
To: Tomasz Torcz <zdzichu@irc.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: waiting 10s before mounting root filesystem?
Message-ID: <20041231181836.GA3086@node1.opengeometry.net>
Mail-Followup-To: Tomasz Torcz <zdzichu@irc.pl>,
	linux-kernel@vger.kernel.org
References: <20041229005922.GA2520@node1.opengeometry.net> <20041230152531.GB5058@logos.cnet> <Pine.LNX.4.61.0412310011400.3494@dragon.hygekrogen.localhost> <Pine.LNX.4.61.0412310234040.4725@dragon.hygekrogen.localhost> <20041231035834.GA2421@node1.opengeometry.net> <20041231014905.30b05a11.akpm@osdl.org> <41D5376A.8000705@grupopie.com> <20041231034257.7d2f7d39.akpm@osdl.org> <20041231173643.GA2741@node1.opengeometry.net> <20041231174819.GA15457@irc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041231174819.GA15457@irc.pl>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2004 at 05:49:34PM +0000, Tomasz Torcz wrote:
> On Fri, Dec 31, 2004 at 12:36:43PM -0500, William Park wrote:
> > My USB key drive takes 5s to show up as SCSI, from the moment 'uhci_hcd'
> > and 'usb-storage' spit out message.  I don't know why.  Internally, USB
> > key drive is solid state flash memory, so it should be faster than any
> > spinning disks.
> 
>  USB keys driven by UB driver come up instantly.

Kernel Helpfile says:

    CONFIG_BLK_DEV_UB:
	This driver supports certain USB attached storage devices
	such as flash keys.
	Warning: Enabling this cripples the usb-storage driver.
	If unsure, say N.

I need 'usb-storage', because USB key drive is supposed to be portable
harddisk.
