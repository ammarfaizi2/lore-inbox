Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbTELQfW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 12:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbTELQfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 12:35:22 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:20206 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262267AbTELQfV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 12:35:21 -0400
Date: Mon, 12 May 2003 09:49:48 -0700
From: Greg KH <greg@kroah.com>
To: Mace Moneta <mmoneta@optonline.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [bug] 2.4.21-rc2 kernel panic USB sched.c:564
Message-ID: <20030512164948.GA28136@kroah.com>
References: <1052600695.12657.4.camel@optonline.net> <20030511054554.GB7729@kroah.com> <1052661635.30223.26.camel@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052661635.30223.26.camel@optonline.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 11, 2003 at 10:00:36AM -0400, Mace Moneta wrote:
> On Sun, 2003-05-11 at 01:45, Greg KH wrote:
> > On Sat, May 10, 2003 at 05:04:56PM -0400, Mace Moneta wrote:
> > > When Attempting to sync a Handspring Visor (PalmOS USB device), I
> > > sometimes (about 1 time out of 4) get the following panic.  
> > 
> > can you run that oops through ksymoops so that we can see where it died
> > at?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Here you go:

Does the same thing happen if you use the uhci.o driver instead of the
usb-uhci.o driver?

thanks,

greg k-h
