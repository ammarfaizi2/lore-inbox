Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272979AbSISU5m>; Thu, 19 Sep 2002 16:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272983AbSISU5m>; Thu, 19 Sep 2002 16:57:42 -0400
Received: from mta06ps.bigpond.com ([144.135.25.138]:59110 "EHLO
	mta06ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S272979AbSISU5l>; Thu, 19 Sep 2002 16:57:41 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.5.26 hotplug failure
Date: Fri, 20 Sep 2002 06:56:23 +1000
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <200207180950.42312.duncan.sands@wanadoo.fr> <E17rwAI-0000vM-00@starship> <20020919164924.GB15956@kroah.com>
In-Reply-To: <20020919164924.GB15956@kroah.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209200656.23956.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 20 Sep 2002 02:49, Greg KH wrote:
> The main reason is this information is no longer available to the USB
> core.  It isn't keeping a list of registered drivers anymore, only the
> driver core is.  So there's no way that usbfs can get to that
> information.  As the info is available in driverfs, duplication of it in
> usbfs would be bloat.
This doesn't follow. driverfs != driver core, just as usbfs != USB core.

I wasn't joking about putting back the /proc/bus/usb/drivers file. This is 
really going to hurt us in 2.6. 

Brad

- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9ijn3W6pHgIdAuOMRAmU+AKCFhvEl2SmXYiYpOQk6CDWrpZhpSACgwh3p
nczKbUd5dYb1V2Ycbk2/eRE=
=RLuK
-----END PGP SIGNATURE-----

