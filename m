Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVGYU0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVGYU0e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 16:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVGYU0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 16:26:34 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:35667 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S261497AbVGYU0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 16:26:33 -0400
Date: Mon, 25 Jul 2005 22:26:32 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Andreas Baer <lnx1@gmx.net>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org,
       pmarques@grupopie.com
Subject: Re: Problem with Asus P4C800-DX and P4 -Northwood-
Message-ID: <20050725202631.GB20811@harddisk-recovery.com>
References: <42E4373D.1070607@gmx.net> <20050725051236.GS8907@alpha.home.local> <42E4E4B0.6050904@gmx.net> <20050725152425.GA24568@alpha.home.local> <42E542D5.3080905@gmx.net> <20050725200330.GA20811@harddisk-recovery.nl> <42E547CA.90108@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E547CA.90108@gmx.net>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 10:12:58PM +0200, Andreas Baer wrote:
> Erik Mouw wrote:
> >Easy: Drives don't have the same speed on all tracks. The platters are
> >built-up from zones with different recording densities: zones near the
> >center of the platters have a lower recording density and hence a lower
> >datarate (less bits/second pass under the head). Zones at the outer
> >diameter have a higher recording density and a higher datarate.
> 
> So it has definitely nothing to do with filesystem? I also thought about 
> physical reasons because I don't think the hdparm depends on filesystems...

That's right, hdparm doesn't care about filesystems. The speed
difference is caused by the physical geometry of the drive.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
