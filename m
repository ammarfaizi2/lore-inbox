Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261297AbSJYH12>; Fri, 25 Oct 2002 03:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261298AbSJYH12>; Fri, 25 Oct 2002 03:27:28 -0400
Received: from mta06bw.bigpond.com ([139.134.6.96]:12003 "EHLO
	mta06bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S261297AbSJYH11>; Fri, 25 Oct 2002 03:27:27 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Josh Myer <jbm@joshisanerd.com>, linux-usb-devel@lists.sourceforge.net,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KB Gear JamStudio USB Tablet
Date: Fri, 25 Oct 2002 17:25:04 +1000
User-Agent: KMail/1.4.5
References: <Pine.LNX.4.44.0210250200290.25878-200000@blessed>
In-Reply-To: <Pine.LNX.4.44.0210250200290.25878-200000@blessed>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200210251725.04957.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 25 Oct 2002 17:04, Josh Myer wrote:
> Comments highly encouraged, thanks. I'd like to get this driver cleaned up
> a little before submitting, but I'm not quite certain where to start.
My initial thought is you are missing an input_sync() call in your irq() 
function.
When you go to 2.5, you also need the new input_init_dev() call.
Maybe a physical path? [ might need 2.5 for that too ]

> The code is based heavily on the wacom driver, and a big "You Rule!" to
> Pavel and anyone else involved with the Input layer. It may be a little
Vojtech is the man.

> convoluted, and slightly non-intuitive, but it's a hell of a lot better
> than the USB HID spec!
Anything looks good if you compare it to a low enough standard :)

- -- 
http://linux.conf.au. 22-25Jan2003. Perth, Aust. I'm registered. Are you?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9uPHQW6pHgIdAuOMRAhSxAJ94t+o/pc+XulH6ExISIpqN0lW+rQCgh8l1
kSFzdywZDVJpBN5+EcBUvPw=
=NuuF
-----END PGP SIGNATURE-----

