Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVBGWyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVBGWyL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 17:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVBGWwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 17:52:25 -0500
Received: from bbned23-32-100.dsl.hccnet.nl ([80.100.32.23]:51619 "EHLO
	fw-loc.vanvergehaald.nl") by vger.kernel.org with ESMTP
	id S261336AbVBGWvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 17:51:55 -0500
Date: Mon, 7 Feb 2005 23:51:39 +0100
From: Toon van der Pas <toon@hout.vanvergehaald.nl>
To: Ali Bayazit <listeci@bayazit.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Judith und Mirko Kloppstech <jugal@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suggestion for CD filesystem for Backups
Message-ID: <20050207225138.GC9850@hout.vanvergehaald.nl>
References: <415204E0.9010203@gmx.net> <1095956209.6776.36.camel@localhost.localdomain> <1096003099.16849.16.camel@mevlevi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096003099.16849.16.camel@mevlevi>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 01:18:19AM -0400, Ali Bayazit wrote:
> 
> On Thu, 2004-09-23 at 17:16 +0100, Alan Cox wrote:
> > On Iau, 2004-09-23 at 00:04, Judith und Mirko Kloppstech wrote:
> > > Why not write a file system on top of ISO9660 which uses the rest of the 
> > > CD to write error correction. If a sector becomes unreadable, the error 
> > > correction saves the data. Besides, a tool for testing the error rate 
> > > and the safety of the data can be easily written for a normal CD-ROM drive.
> > > 
> > > The data for error correction might be written into a file so that the 
> > > CD can be read using any System, but Linux provides error correction.
> > 
> > Send patches, or possibly if you are dumping tars and the like just
> > write yourself an app to generate a second file of ECC data.
> 
> Wouldn't it be safer to do ECC on meta-data also?
> That probably means replacing ISO9660 though.

There seems to be a good user space alternative for this purpose:

	http://dvdisaster.berlios.de

Regards,
Toon.
-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
