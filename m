Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTELRcv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 13:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbTELRcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 13:32:50 -0400
Received: from mta1.srv.hcvlny.cv.net ([167.206.5.4]:17860 "EHLO
	mta1.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S262328AbTELRct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 13:32:49 -0400
Date: Mon, 12 May 2003 13:45:30 -0400
From: Mace Moneta <mmoneta@optonline.net>
Subject: Re: [bug] 2.4.21-rc2 kernel panic USB sched.c:564
In-reply-to: <20030512164948.GA28136@kroah.com>
To: linux-kernel@vger.kernel.org
Reply-to: mmoneta@optonline.net
Message-id: <1052761529.25189.21.camel@optonline.net>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5)
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <1052600695.12657.4.camel@optonline.net>
 <20030511054554.GB7729@kroah.com> <1052661635.30223.26.camel@optonline.net>
 <20030512164948.GA28136@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I replaced usb-uhci with uhci, and tried to recreate the problem.  While
this is easily recreated with usb-uhci, even after 30 attempts uhci
operated without error.

It definitely appears to be a problem with usb-uhci.

Mace

On Mon, 2003-05-12 at 12:49, Greg KH wrote: 
> On Sun, May 11, 2003 at 10:00:36AM -0400, Mace Moneta wrote:
> > On Sun, 2003-05-11 at 01:45, Greg KH wrote:
> > > On Sat, May 10, 2003 at 05:04:56PM -0400, Mace Moneta wrote:
> > > > When Attempting to sync a Handspring Visor (PalmOS USB device), I
> > > > sometimes (about 1 time out of 4) get the following panic.  
> > > 
> > > can you run that oops through ksymoops so that we can see where it died
> > > at?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Here you go:
> 
> Does the same thing happen if you use the uhci.o driver instead of the
> usb-uhci.o driver?
> 
> thanks,
> 
> greg k-h

