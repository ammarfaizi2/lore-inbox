Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131271AbRAGV3X>; Sun, 7 Jan 2001 16:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132533AbRAGV3N>; Sun, 7 Jan 2001 16:29:13 -0500
Received: from 209.102.21.2 ([209.102.21.2]:50955 "EHLO dragnet.seagull.net")
	by vger.kernel.org with ESMTP id <S131271AbRAGV25>;
	Sun, 7 Jan 2001 16:28:57 -0500
Message-ID: <3A58AF28.8359C3A7@goingware.com>
Date: Sun, 07 Jan 2001 18:02:16 +0000
From: "Michael D. Crawford" <crawford@goingware.com>
Organization: GoingWare Inc. - Expert Software Development and Consulting
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, newbie@xfree86.org
CC: jhartmann@valinux.com, srwalter@yahoo.com
Subject: ReL DRI doesn't work on 2.4.0 but does on prerelease-ac5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get, with XFree86 4.0.1 and an ATI Rage Millenium card:

> (EE) r128(0): R128DRIScreenInit failed (DRM version = 2.1.2, expected 1.0.x). 
> Disabling DRI. 

Jeff Hartmann (jhartmann@valinux.com) says:

> XFree 4.0.2 will fix this

OK, so I'll give a try at building 4.0.2 the Slackware way.  While unfortunately
the Slackware packages for 4.0.2 are not yet available, the diffs to the 4.0.1
sources (mostly the Imake files and site.def) used to build their version (with
its different directory layout) are in:

ftp://ftp.slackware.com/pub/slackware/slackware-current/contrib/contrib-sources/XFree86-4.0.1/

Steven Walter (srwalter@yahoo.com) suggested that the incompatibility would be
fixed by using a -ac version since 2.4.0.  I built 2.4.0, but it didn't fix it,
so given what Jeff said I guess this is a feature not a bug.

Mike
-- 
Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

   Tilting at Windmills for a Better Tomorrow.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
