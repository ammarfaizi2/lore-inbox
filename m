Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbUBTNbZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 08:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbUBTMvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:51:47 -0500
Received: from mout1.freenet.de ([194.97.50.132]:64450 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S261196AbUBTMsf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:48:35 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Greg KH <greg@kroah.com>
Subject: Re: [ANNOUNCE] udev 018 release
Date: Fri, 20 Feb 2004 13:48:19 +0100
User-Agent: KMail/1.6.50
References: <20040219185932.GA10527@kroah.com> <20040219191315.GB10527@kroah.com>
In-Reply-To: <20040219191315.GB10527@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200402201348.29745.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 19 February 2004 20:13, you wrote:
> On Thu, Feb 19, 2004 at 10:59:32AM -0800, Greg KH wrote:
> > I've released the 018 version of udev.  It can be found at:
> >  	kernel.org/pub/linux/utils/kernel/hotplug/udev-018.tar.gz
> 
> As of this release, I've been running with udev managing my /dev for me
> exclusively on my main email and development machine.  This is a major
> milestone for udev and it proves that it is a viable solution.

I'm running udev for some time now on my main development
machine and it works (almost) great.
Thanks Greg and all the others who made it possible!

But I've a little issue left. My parallel port doesn't show
up in /udev. I guess it's because of missing sysfs support?
I'm running linux-2.6.3.
I did not find an entry for the parallel port in sysfs.
If I create the device node manually I can access lp.

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFANgIcFGK1OIvVOP4RAlMNAJ4zv/qII8xajnelmmgCw7efVJqjTwCfVs4D
/7k2jBdxoXYwSIHn+iSreYA=
=/yKw
-----END PGP SIGNATURE-----
