Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbTFHNL3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 09:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbTFHNL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 09:11:29 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:10231 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S261787AbTFHNL1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 09:11:27 -0400
Date: Sun, 8 Jun 2003 09:01:06 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: compaq raid drivers
Message-ID: <20030608090105.A16496@mail.kroptech.com>
References: <200306072357.QAA04100@hpat542.atl.hp.com> <20030608115844.GC6662@wohnheim.fh-wedel.de> <20030608120453.GD6662@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030608120453.GD6662@wohnheim.fh-wedel.de>; from joern@wohnheim.fh-wedel.de on Sun, Jun 08, 2003 at 02:04:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 08, 2003 at 02:04:53PM +0200, Jörn Engel wrote:
> On Sun, 8 June 2003 13:58:44 +0200, Jörn Engel wrote:
> > 
> > "Charles White <arrays@compaq.com>" bounces.  Does anyone have a
> > better patch for the MAINTAINERS than the one below?
> 
> Could have guessed so, the list bounces as well.  And so does the
> other compaq address.  Updated patch.

The patch that really wants applying is this one from Steve Cameron back
in February:

Date:	Thu, 27 Feb 2003 10:04:31 +0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: charles.white@hp.com, amy.vanzant-hodge@hp.com
Subject: [PATCH] 2.5.21-pre5, MAINTAINTERS, cciss/cpqarray/cpqfc

Charles White and Amy Vanzant-Hodge have moved on
to do other things. 

-- steve

--- lx2421p5/MAINTAINERS~maint	2003-02-27 09:57:04.000000000 +0600
+++ lx2421p5-scameron/MAINTAINERS	2003-02-27 09:59:38.000000000 +0600
@@ -335,25 +335,25 @@ L:	codalist@coda.cs.cmu.edu
 W:	http://www.coda.cs.cmu.edu/
 S:	Maintained
 
-COMPAQ FIBRE CHANNEL 64-bit/66MHz PCI non-intelligent HBA
-P:      Amy Vanzant-Hodge 
-M:      Amy Vanzant-Hodge (fibrechannel@compaq.com)
-L:	compaqandlinux@cpqlin.van-dijk.net
-W:	ftp.compaq.com/pub/products/drivers/linux
-S:      Supported
+HP (was COMPAQ) FIBRE CHANNEL 64-bit/66MHz PCI non-intelligent HBA
+P:      Stephen Cameron
+M:      arrays@hp.com 
+M:      steve.cameron@hp.com
+L:	cpqfc-discuss@lists.sourceforge.net
+S:      Odd Fixes
+
+HP (was COMPAQ) SMART2 RAID DRIVER
+P:	Stephen Cameron
+M:	arrays@hp.com
+M:	steve.cameron@hp.com
+L:	cpqarray-discuss@lists.sourceforge.net
+S:	Odd Fixes
 
-COMPAQ SMART2 RAID DRIVER
-P:	Charles White	
-M:	Charles White <arrays@compaq.com>
-L:	compaqandlinux@cpqlin.van-dijk.net
-W:	ftp.compaq.com/pub/products/drivers/linux
-S:	Supported	
-
-COMPAQ SMART CISS RAID DRIVER 
-P:	Charles White
-M:	Charles White <arrays@compaq.com>
-L:	compaqandlinux@cpqlin.van-dijk.net
-W:	ftp.compaq.com/pub/products/drivers/linux	
+HP (was COMPAQ) SMART CISS RAID DRIVER 
+P:	Stephen Cameron
+M:	arrays@hp.com
+M:	steve.cameron@hp.com
+L:	cciss-discuss@lists.sourceforge.net
 S:	Supported 
 
 COMPUTONE INTELLIPORT MULTIPORT CARD


