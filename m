Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262156AbVBAWh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbVBAWh1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 17:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbVBAWeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 17:34:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:46532 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262150AbVBAWa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 17:30:27 -0500
Date: Tue, 1 Feb 2005 14:30:08 -0800
From: Greg KH <greg@kroah.com>
To: Paul Mundt <paul.mundt@nokia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SuperHyway bus support
Message-ID: <20050201223008.GA14331@kroah.com>
References: <20041027075248.GA26760@pointless.research.nokia.com> <20050107072222.GB24441@kroah.com> <20050107094103.GA7408@pointless.research.nokia.com> <20050107162945.GA19043@pointless.research.nokia.com> <20050112081722.GA2745@kroah.com> <20050112124836.GA9315@pointless.research.nokia.com> <20050201220552.GA13994@kroah.com> <20050201222327.GA3200@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050201222327.GA3200@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 11:23:27PM +0100, Sam Ravnborg wrote:
> On Tue, Feb 01, 2005 at 02:05:52PM -0800, Greg KH wrote:
> > >  drivers/sh/Makefile                      |    6 
> > >  drivers/sh/superhyway/Makefile           |    7 +
> > >  drivers/sh/superhyway/superhyway-sysfs.c |   45 ++++++
> > >  drivers/sh/superhyway/superhyway.c       |  201 +++++++++++++++++++++++++++++++
> > >  include/linux/superhyway.h               |   79 ++++++++++++
> > >  5 files changed, 338 insertions(+)
> 
> Why does it need a .h file in include/linux/?
> Only use include/linux/* for .h files which is used by other parts of
> the kernel.
> 
> [I've lost the original mail - so cannot see the actual source].

Other parts of the kernel will use that .h file when they register
themselves with the sh bus.  Right Paul?

thanks,

greg k-h
