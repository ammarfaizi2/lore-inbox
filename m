Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUDDLVy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 07:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbUDDLVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 07:21:54 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:41111 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S262337AbUDDLVa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 07:21:30 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-usb-usersl@lists.sourceforge.net
Subject: Re: 2.6.5-rc3-mm4 breaks xsane, hangs on device scan at launch
Date: Sun, 4 Apr 2004 07:21:28 -0400
User-Agent: KMail/1.6
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
References: <200404032113.01355.gene.heskett@verizon.net>
In-Reply-To: <200404032113.01355.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404040721.28811.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [151.205.9.48] at Sun, 4 Apr 2004 06:21:29 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 April 2004 21:13, Gene Heskett wrote:
>Greetings;
>
>You'll find a sysrq -t capture attached.  xsane is hung in the
> opening device scan, leaving that little window, and its totally
> unkillable by any means but a reboot, which brings up the you're
> running as root warning as it restarts xsane, and it can be
> canceled from there.
>
>If, in this condition, I do a lsusb, that too will hang near the end
>of the mouse report section.  The usb mouse continues to function
>norrmally.

I forgot to mention that lsusb runs normally before xsane has been 
run.  I didn't make that clear above.

>This is 100% repeatable, and everything works nominally if I reboot
> to 2.6.5-rc3-mm3 or earlier.

2.6.5 is apparently stable in this regard.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
