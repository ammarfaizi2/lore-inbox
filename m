Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965430AbWI0HgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965430AbWI0HgR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 03:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965429AbWI0HgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 03:36:17 -0400
Received: from rwcrmhc15.comcast.net ([204.127.192.85]:33480 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S965428AbWI0HgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 03:36:13 -0400
Subject: Re: GPLv3 Position Statement
From: Sergey Panov <sipan@sipan.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0609270753590.19275@yvahk01.tjqt.qr>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
	 <1159319508.16507.15.camel@sipan.sipan.org>
	 <Pine.LNX.4.61.0609270753590.19275@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Home
Date: Wed, 27 Sep 2006 03:36:09 -0400
Message-Id: <1159342569.2653.30.camel@sipan.sipan.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-27 at 07:55 +0200, Jan Engelhardt wrote: 
> >Fuzzy (but realistic) logic:
> >
> >   kernel != operating_system
> >
> >   operating_system > kernel
> >
> >   operating_system - kernel = 0
> >
> >   kernel - (operating_system - kernel) < 0
> >
> >Another (license compatibility) Q. is:
> >    If the (operating_system - kernel) is re-licensed under v.3 and
> >    the kernel is still under v.2 , would it be possible to distribute
> >    combination (kernel + (operating_system - kernel)) ?
> 
> If by operating system you mean the surrounding userland application,

almost, surrounding_userland_applications = (operating_system - kernel) 

> then yes, why should there be a problem with a GPL2 kernel and a GPL3 
> userland? After all, the userland is not only GPL, but also BSD and 
> other stuff.

It was not a problem with GPL[0-1]/BSD/MIT license, but is it still true
with GPL3? What is the difference between running application on the top
of the kernel "A" and linked with the library "B"?

> >The last Q. is how good is the almost forgotten Hurd kernel?
> 
> Wild guess: At most on par with Minix.

... ???. I am not so sure. Kernel is really a small thing. The VMWare
proprietary hyper-visor was/is reusing Linux drivers with ease, why BSD or
Hurd can not do the same? As a former (Linux) driver writer I like to show the
following numbers to my friends:

$ du -s lib kernel  net drivers
980     lib
1728    kernel
16132   net
130872  drivers

and:

$ find ./kernel -type f -exec cat  {} + | wc -l
48312
$ find ./drivers -type f -exec cat  {} + | wc -l
3367849

================================================================

PS. Given that some of the sub-systems (e.g SCSI) in Linux still suck
badly, other OS (not as in Operating Systems but as in Open Source)
alternatives might eventually gain some ground in the enterprise
environment.

 


