Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265530AbUABNAl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 08:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265531AbUABNAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 08:00:41 -0500
Received: from mout2.freenet.de ([194.97.50.155]:34967 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S265530AbUABNAe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 08:00:34 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Steve Youngs <sryoungs@bigpond.net.au>
Subject: Re: udev - please help me to understand
Date: Fri, 2 Jan 2004 14:00:19 +0100
User-Agent: KMail/1.5.93
References: <microsoft-free.87r7yiinaj.fsf@eicq.dnsalias.org>
In-Reply-To: <microsoft-free.87r7yiinaj.fsf@eicq.dnsalias.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       linux-hotplug-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200401021400.29569.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 02 January 2004 12:48, Steve Youngs wrote:
> I have zero hot-pluggable devices (that might change somewhere in the
> distant future, but for now I don't have any).  And never in my wildest
> dreams could I ever imagine running out of device numbers.

Yea, _you_ can't imagine this. :) But Kernel developers can... .

> Reading through the documentation that I've found about udev, your
> main points seem to be about:
>
>         - udev vs devfs
>         - running out of device major/minor numbers
>         - not having to worry about major/minor numbers
>
> For me, the first point is moot because I don't use devfs.  The second
> point is just plain ridiculous, there is just _no_ way that it could
> happen (remember that I'm talking about my own situation).

I don't think so.
Every new device needs a unique number, that _no other_ device uses.
As more and more devices are developed, we are running out of device
numbers. (well, that may take a while with 32-bit device numbers,
but it may appear so).

> So, Greg, is there _any_ reason why I'd want to be using udev?

(Hm, I'm not Greg, but...)
Because it's cool. :)
No, you're right.
I am not going to use udev or devfs on my server
for example. The reason is quite simple. This server will be running
linux-2.4 until it dies and I will never add some more device to it.
So there is no point of using udev or devfs on it. I know the hardware,
create all nodes for it and it runs (without all the problems devfs
and udev still provide).
But on my main Computer I am going to use udev, because I love it's
flexibility.

_You_ have to decide if you need udev or don't. Nobody else can decide
it for you.

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE/9WtsFGK1OIvVOP4RAoD2AKCMOAVWp226hzMQxju9Yo7t8uO7FQCguSJe
7XksJs4zqwCeFyBQkcBOn98=
=chS9
-----END PGP SIGNATURE-----
