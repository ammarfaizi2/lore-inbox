Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269981AbSISGWO>; Thu, 19 Sep 2002 02:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269984AbSISGWO>; Thu, 19 Sep 2002 02:22:14 -0400
Received: from mta05ps.bigpond.com ([144.135.25.137]:61386 "EHLO
	mta05ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S269981AbSISGWN>; Thu, 19 Sep 2002 02:22:13 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: "Michael Duane" <Mike.Duane@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: CDCether.c
Date: Thu, 19 Sep 2002 16:20:57 +1000
User-Agent: KMail/1.4.5
References: <4C568C6A13479744AA1EA3E97EEEB3231B7DDC@schumi.digeo.com>
In-Reply-To: <4C568C6A13479744AA1EA3E97EEEB3231B7DDC@schumi.digeo.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209191620.58022.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thu, 19 Sep 2002 09:49, Michael Duane wrote:
> Who is the maintainer of CDCEther.c?  I am having a problem
> with packets getting "wedged" somewhere on the way out
> and need to know if others have reported this problem.
Others have reported probems that normally look something like "it works fine 
for some minutes to days, and then all connectivity stops, till I reboot or 
re-insert the module", but I can't duplicate. Does this match your problem?

There are some races, but I can't explain the problem from them. I do need to 
fix the races, but I only do this when I have some spare time (after work, 
SO, and some other hobbies).

> I'm running the 2.4.17 kernel and using a Broadcom DOCSIS
> modem based around a 3345.
Most people have reported the problem with Via UHCI chipsets, and usb-uhci 
driver. Does this match your configuration?

You might care to upgrade the kernel too.

Brad

- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9iWzJW6pHgIdAuOMRAvXrAJ9JfDSnx25dKI7yXvQC2XjNEydS+wCgpKMe
kSP0H8AB5Sj8Ebo6SGAPVNs=
=RTI4
-----END PGP SIGNATURE-----

