Return-Path: <linux-kernel-owner+w=401wt.eu-S1161122AbXALWCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161122AbXALWCQ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 17:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161120AbXALWCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 17:02:16 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:17450 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161121AbXALWCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 17:02:12 -0500
Date: Fri, 12 Jan 2007 14:01:12 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>, jkosina@suse.cz,
       linux-input@atrey.karlin.mff.cuni.cz, Adrian Bunk <bunk@stusta.de>
Subject: Re: Fwd: [PATCH] Fix some ARM builds due to HID brokenness
Message-Id: <20070112140112.902bbdaa.randy.dunlap@oracle.com>
In-Reply-To: <20070112134405.af4465c0.akpm@osdl.org>
References: <20070112210015.GA2923@dyn-67.arm.linux.org.uk>
	<20070112134405.af4465c0.akpm@osdl.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2007 13:44:05 -0800 Andrew Morton wrote:

> On Fri, 12 Jan 2007 21:00:15 +0000
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 
> > Could we please have this (or a proper fix) in before 2.6.20 to resolve
> > the regression please?
> > 
> >
> > ...
> >
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -6,6 +6,7 @@ menu "HID Devices"
> >  
> >  config HID
> >  	tristate "Generic HID support"
> > +	depends on INPUT
> >  	default y
> >  	---help---
> >  	  Say Y here if you want generic HID support to connect keyboards,
> > 
> 
> This was merged a week ago..

Right, we are past that to a new patch now.

---
~Randy
