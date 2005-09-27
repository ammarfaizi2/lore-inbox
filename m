Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbVI0H0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbVI0H0Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 03:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbVI0H0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 03:26:25 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:1998 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S964847AbVI0H0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 03:26:24 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.14-rc2: USB storage-related #GP on x86-64
Date: Tue, 27 Sep 2005 09:26:42 +0200
User-Agent: KMail/1.8.2
Cc: torvalds@osdl.org, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200509231502.02344.rjw@sisk.pl> <200509231843.51432.rjw@sisk.pl> <20050926202753.GB18523@kroah.com>
In-Reply-To: <20050926202753.GB18523@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509270926.42880.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 26 of September 2005 22:27, Greg KH wrote:
> On Fri, Sep 23, 2005 at 06:43:50PM +0200, Rafael J. Wysocki wrote:
> > On Friday, 23 of September 2005 15:06, Greg KH wrote:
> > > On Fri, Sep 23, 2005 at 03:02:01PM +0200, Rafael J. Wysocki wrote:
> > > > Hi,
> > > > 
> > > > I've just triggered a general protection fault on Asus L5D (x86-64) by
> > > > unplugging a USB floppy.
> > > 
> > > Can you try the latest -git snapshots?  The scsi changes that should
> > > have fixed this went in after -rc2.
> > 
> > Tried -git3, works.
> 
> Great, thanks for letting us know.
> 
> > Tested with a pendrive instead of the floppy, but I assume it doesn't
> > matter?
> 
> It shouldn't, but it can't hurt to test :)

OK.  Tested on -git6 and it works too. ;-)

Greetings,
Rafael
