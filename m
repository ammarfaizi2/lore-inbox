Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbULMPCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbULMPCR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 10:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbULMPCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 10:02:17 -0500
Received: from smtp08.auna.com ([62.81.186.18]:28036 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S261233AbULMPBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 10:01:51 -0500
Date: Mon, 13 Dec 2004 15:01:49 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.10-rc3-mm1
To: linux-kernel@vger.kernel.org
References: <20041213020319.661b1ad9.akpm@osdl.org>
In-Reply-To: <20041213020319.661b1ad9.akpm@osdl.org> (from akpm@osdl.org on
	Mon Dec 13 11:03:19 2004)
X-Mailer: Balsa 2.2.6
Message-Id: <1102950109l.7596l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-AoqsWopICtinjOmWFnpV"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-AoqsWopICtinjOmWFnpV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On 2004.12.13, Andrew Morton wrote:
>=20
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc3/=
2.6.10-rc3-mm1/
>=20

I remember that people agreed that this should not be _GPL:

http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D109935991217693&w=3D2

--- linux-2.6.10-rc2-jam2/drivers/base/class_simple.c.orig	2004-11-21 23:47=
:05.000000000 +0100
+++ linux-2.6.10-rc2-jam2/drivers/base/class_simple.c	2004-11-21 23:47:46.0=
00000000 +0100
@@ -91,7 +91,7 @@
 	kfree(cs);
 	return ERR_PTR(retval);
 }
-EXPORT_SYMBOL_GPL(class_simple_create);
+EXPORT_SYMBOL(class_simple_create);
=20
 /**
  * class_simple_destroy - destroys a struct class_simple structure
@@ -107,7 +107,7 @@
=20
 	class_unregister(&cs->class);
 }
-EXPORT_SYMBOL_GPL(class_simple_destroy);
+EXPORT_SYMBOL(class_simple_destroy);
=20
 /**
  * class_simple_device_add - adds a class device to sysfs for a character =
driver
@@ -166,7 +166,7 @@
 	kfree(s_dev);
 	return ERR_PTR(retval);
 }
-EXPORT_SYMBOL_GPL(class_simple_device_add);
+EXPORT_SYMBOL(class_simple_device_add);
=20
 /**
  * class_simple_set_hotplug - set the hotplug callback in the embedded str=
uct class
@@ -184,7 +184,7 @@
 	cs->class.hotplug =3D hotplug;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(class_simple_set_hotplug);
+EXPORT_SYMBOL(class_simple_set_hotplug);
=20
 /**
  * class_simple_device_remove - removes a class device that was created wi=
th class_simple_device_add()
@@ -213,4 +213,4 @@
 		spin_unlock(&simple_dev_list_lock);
 	}
 }
-EXPORT_SYMBOL_GPL(class_simple_device_remove);
+EXPORT_SYMBOL(class_simple_device_remove);

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-rc2-jam4 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-1mdk)) #4


--=-AoqsWopICtinjOmWFnpV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBva7dRlIHNEGnKMMRAu+kAJ4nNLaG1k1KS5tyla92FCl3aO2kVQCdFPVq
htB7ZqwXaUBco9tYmqDcK/4=
=NeHH
-----END PGP SIGNATURE-----

--=-AoqsWopICtinjOmWFnpV--

