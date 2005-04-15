Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbVDOOxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVDOOxi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 10:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVDOOxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 10:53:38 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:3968 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S261824AbVDOOxf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 10:53:35 -0400
Date: Fri, 15 Apr 2005 10:53:34 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Joerg Pommnitz <pommnitz@yahoo.com>
cc: kernel <linux-kernel@vger.kernel.org>,
       linux-usb-user <linux-usb-users@lists.sourceforge.net>
Subject: Re: [Linux-usb-users] 2.6 PCMCIA/USB question
In-Reply-To: <20050415082048.1497.qmail@web51409.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44L0.0504151052010.6185-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2005, Joerg Pommnitz wrote:

> Hello all,
> I have a question that I could not figure out from other sources. I have
> the following hardware: an integrated CardBus USB host adapter with a
> connected USB serial device with three interfaces (normally
> ttyUSB0...ttyUSB2). Now I want to use 3 of these devices (remember: they
> are integrated, so I can't just plug the USB device onto the same host
> adapter). I know device A is in CardBus slot 1, device B is in CardBus
> slot 2 and so on. 
> 
> Now the question: How do I figure out which ttyUSBx belongs to which
> device?

You can look in the system log.  If you want, you can actually control 
which goes where by creating a udev configuration file.

Alan Stern

