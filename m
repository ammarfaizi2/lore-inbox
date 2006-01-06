Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932757AbWAFR0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932757AbWAFR0i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 12:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932793AbWAFR0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 12:26:37 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56076 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932788AbWAFR0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 12:26:35 -0500
Date: Fri, 6 Jan 2006 18:26:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: "John L. Villalovos" <john.l.villalovos@intel.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [2.6 patch] MAINTAINERS: remove the outdated DAC960 entry
Message-ID: <20060106172629.GQ12131@stusta.de>
References: <43BC45DE.5060303@intel.com> <Pine.LNX.4.58.0601041406210.19134@shark.he.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0601041406210.19134@shark.he.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 02:07:01PM -0800, Randy.Dunlap wrote:
> On Wed, 4 Jan 2006, John L. Villalovos wrote:
> 
> > From: John L. Villalovos <john.l.villalovos@intel.com>
> >
> > While parsing the MAINTAINERS file I disovered one entry was missing a colon.
> > This patch adds the one missing colon.
> >
> > ---
> > diff -r 8441517e7e79 MAINTAINERS
> > --- a/MAINTAINERS       Thu Jan  5 04:00:05 2006
> > +++ b/MAINTAINERS       Wed Jan  4 13:49:27 2006
> > @@ -681,7 +681,7 @@
> >
> >   DAC960 RAID CONTROLLER DRIVER
> >   P:     Dave Olien
> > -M      dmo@osdl.org
> > +M:     dmo@osdl.org
> >   W:     http://www.osdl.org/archive/dmo/DAC960
> >   L:     linux-kernel@vger.kernel.org
> >   S:     Maintained
> 
> That would be helpful except that Dave is no longer at OSDL
> and is no longer maintaining that driver...

Let's remove this obsolete entry.

> ~Randy

cu
Adrian


<--  snip  -->


Randy Dunlap:
Dave is no longer at OSDL and is no longer maintaining that driver.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-mm1-full/MAINTAINERS.old	2006-01-06 18:23:37.000000000 +0100
+++ linux-2.6.15-mm1-full/MAINTAINERS	2006-01-06 18:23:44.000000000 +0100
@@ -696,13 +696,6 @@
 W:	http://www.cyclades.com/
 S:	Supported
 
-DAC960 RAID CONTROLLER DRIVER
-P:	Dave Olien
-M	dmo@osdl.org
-W:	http://www.osdl.org/archive/dmo/DAC960
-L:	linux-kernel@vger.kernel.org
-S:	Maintained
-
 DAMA SLAVE for AX.25
 P:	Joerg Reuter
 M:	jreuter@yaina.de

