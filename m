Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbTELXzz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 19:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbTELXzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 19:55:55 -0400
Received: from cmu-24-35-32-166.mivlmd.cablespeed.com ([24.35.32.166]:7172
	"EHLO lap.molina") by vger.kernel.org with ESMTP id S262974AbTELXzy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 19:55:54 -0400
Date: Mon, 12 May 2003 20:07:59 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@lap.molina
To: linux-kernel@vger.kernel.org
cc: Russell King <rmk@arm.linux.org.uk>
Subject: Re: PCMCIA 2.5.X sleeping from illegal context
In-Reply-To: <1052781365.1185.5.camel@teapot.felipe-alfaro.com>
Message-ID: <Pine.LNX.4.44.0305122001060.1159-100000@lap.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm back to testing with 2.5 and I am not having any issues with PCMCIA in 
2.5.69-bk.  I'm not using any additional patches.  System is Presario 
12XL325 with RedHat 8.0.  It has a Linksys PCMCIA card using the tulip 
driver.

On 13 May 2003, Felipe Alfaro Solana wrote:

> On Tue, 2003-05-13 at 00:31, Russell King wrote:
> > > Does this still happen with all the patches Russell King posted
> > > that everyone else is ignoring ?
> > 
> > I'm in the process of putting the patch in my outgoing patch queue
> > for Linus, otherwise we're not going to make any forward progress.
> 
> Well, your patches do work pretty well for me... I've been playing
> extensively with PCMCIA today, mainly with my 3Com CardBus NIC which has
> really strange TX slowdown problems, by plugging and unplugging it over
> and over again, loading and unloading the 3c59x.ko module and so on. So
> at least, we're making some progress.
> 

