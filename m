Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319026AbSIJAMe>; Mon, 9 Sep 2002 20:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319034AbSIJAMe>; Mon, 9 Sep 2002 20:12:34 -0400
Received: from mta01ps.bigpond.com ([144.135.25.133]:48104 "EHLO
	mta01ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S319026AbSIJAMd>; Mon, 9 Sep 2002 20:12:33 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Vikas Jain <v0j1217@unix.tamu.edu>
Subject: Re: How to talk to joystick from kernel space
Date: Tue, 10 Sep 2002 10:11:29 +1000
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org
References: <Pine.SOL.3.96.1020908204425.19274A-100000@scully.tamu.edu> <1031605114.29718.45.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1031605114.29718.45.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209101011.29965.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 10 Sep 2002 06:58, Alan Cox wrote:
> On Mon, 2002-09-09 at 02:45, Vikas Jain wrote:
> > Can anyone give me some guidance on how do we talk to joystick from
> > kernel space.
>
> Read the documentation supplied with the kernel.
Specifically, you need to talk to the input subsystem, so you should look in 
it's documentation directory.

Why do you want to talk to a joystick anyway? Are you trying to add a driver 
for a particular joystick, or modify behaviour based on some particular 
kernel behaviour?

- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9fTixW6pHgIdAuOMRAi0fAJ4s02szOK28A8jNHW7x3HZ2Q6p77QCfWr5I
21rHrWzsz06tLh+qRpxAdS0=
=yyZL
-----END PGP SIGNATURE-----

