Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278943AbRJ2B5b>; Sun, 28 Oct 2001 20:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278945AbRJ2B5V>; Sun, 28 Oct 2001 20:57:21 -0500
Received: from rosebud.imaginos.net ([64.173.180.66]:29829 "EHLO
	rosebud.imaginos.net") by vger.kernel.org with ESMTP
	id <S278943AbRJ2B5J> convert rfc822-to-8bit; Sun, 28 Oct 2001 20:57:09 -0500
Date: Sun, 28 Oct 2001 17:57:36 -0800 (PST)
From: Jim Hull <imaginos@imaginos.net>
X-X-Sender: <imaginos@rosebud>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Intel EEPro 100 with kernel drivers
In-Reply-To: <20011029021339.B23985@stud.ntnu.no>
Message-ID: <Pine.LNX.4.33.0110281751180.15693-100000@rosebud>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I actually have the same issue but I am not seeing any performance
loss. I do extensive NFS transfers as this box also stores a software raid
array, and aside from the kernel message, I am unaffected.

- From what I understand the problem is a hardware bug, and I believe I read
somewhere that by forcing the network card to use its own IRQ and not
having it share an IRQ will alleviate this problem.

Hope this helps ....

On a side note I run this nic on about 10 production web servers running
fbsd 3.5 receiving extensive traffic loads and have no problems with them
at all.


				Jim


============================
They that give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety.

- --Benjamin Franklin,
Historical Review of Pennyslvania, 1759



On Mon, 29 Oct 2001, [iso-8859-1] Thomas Langås wrote:

Hi!

We've got a lot of machines with the eepro 100 from intel onboard, and when
we try to stress-test the network (running bonnie++ on a nfs-shared
directory on a machine), the network-card says "eth0: Card reports no
resources" to dmesg, and then the "line" appear dead for some time (one
minutte or more). What can be done to remove this error? NFS timesout with
this error (obviously)...

- -- 
Thomas
- -
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE73LeWdygyS8O4zQ0RAnB8AJ4xqGShA8xlANM9pFmbvNWf4Ia2GgCgusjL
ZgmY6+MW8+vzzYIHCdSRDts=
=ql0B
-----END PGP SIGNATURE-----


