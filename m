Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265516AbUABLsr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 06:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265520AbUABLsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 06:48:47 -0500
Received: from gizmo09bw.bigpond.com ([144.140.70.19]:27815 "HELO
	gizmo09bw.bigpond.com") by vger.kernel.org with SMTP
	id S265516AbUABLsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 06:48:45 -0500
Mail-Copies-To: never
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: linux-hotplug-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>
Subject: udev - please help me to understand
Keywords: udev,numbers,device,worry,point,minor,major,devfs
From: Steve Youngs <sryoungs@bigpond.net.au>
X-Face: #/1'_-|5_1$xjR,mVKhpfMJcRh8"k}_a{EkIO:Ox<]@zl/Yr|H,qH#3jJi6Aw(Mg@"!+Z"C
 N_S3!3jzW^FnPeumv4l#,E}J.+e%0q(U>#b-#`~>l^A!_j5AEgpU)>t+VYZ$:El7hLa1:%%L=3%B>n
 K{^jU_{&
Organization: Linux Users - Fanatics Dept.
X-URL: <http://users.bigpond.net.au/sryoungs/>
X-Request-PGP: <http://users.bigpond.net.au/sryoungs/pgp/sryoungs.asc>
X-OpenPGP-Fingerprint: 1659 2093 19D5 C06E D320  3A20 1D27 DB4B A94B 3003
X-Attribution: SY
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
 linux-hotplug-devel@lists.sf.net, Greg KH <greg@kroah.com>
Date: Fri, 02 Jan 2004 21:48:36 +1000
Message-ID: <microsoft-free.87r7yiinaj.fsf@eicq.dnsalias.org>
User-Agent: Gnus/5.1004 (Gnus v5.10.4) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi Greg!

I've been looking at this "udev" thingy and I can't for the life of me
see why I'd need it.  There doesn't appear to be _any_ advantages of
using udev in my present situation.

No, I don't use devfs.

I have zero hot-pluggable devices (that might change somewhere in the
distant future, but for now I don't have any).  And never in my wildest
dreams could I ever imagine running out of device numbers.

Reading through the documentation that I've found about udev, your
main points seem to be about:

        - udev vs devfs
        - running out of device major/minor numbers
        - not having to worry about major/minor numbers

For me, the first point is moot because I don't use devfs.  The second
point is just plain ridiculous, there is just _no_ way that it could
happen (remember that I'm talking about my own situation).  

As for the third point, well, I don't worry about device numbers now.
In the years that I've been using Linux (since 2.0.something) you
could probably count the number of times I've had to worry about
major/minor numbers on the fingers of one hand.  The _only_ times
have been on those incredibly rare occasions when I've needed to
create a new device file in /dev/.

So, Greg, is there _any_ reason why I'd want to be using udev?

I have other questions, but they can wait until I know whether or not
I need the thing in the first place.

Thank you very much for your time and patience.

-- 
|---<Steve Youngs>---------------<GnuPG KeyID: A94B3003>---|
|              Ashes to ashes, dust to dust.               |
|      The proof of the pudding, is under the crust.       |
|------------------------------<sryoungs@bigpond.net.au>---|

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Eicq - The XEmacs ICQ Client <http://eicq.sf.net/>

iEYEABECAAYFAj/1WpgACgkQHSfbS6lLMAM8rQCgxDc0X84iGQ3UKaTLoQONMe+v
QHkAn2FdLKksTxHNpSw2i2KUFic6fxHC
=aP9a
-----END PGP SIGNATURE-----
--=-=-=--
