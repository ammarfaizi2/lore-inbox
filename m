Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269467AbUICAjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269467AbUICAjQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 20:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269403AbUICAiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 20:38:55 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:57484 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S269467AbUICAhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 20:37:40 -0400
Date: Thu, 2 Sep 2004 20:37:35 -0400
From: Johann Koenig <explosive@hvc.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel or Grub bug.
Message-ID: <20040902203735.2801e7f9@localhost.localdomain>
In-Reply-To: <200409022103.i82L2rm1003486@laptop11.inf.utfsm.cl>
References: <1094055985.4635.44.camel@wizej.agilysys.com>
	<200409022103.i82L2rm1003486@laptop11.inf.utfsm.cl>
X-Mailer: Sylpheed-Claws 0.9.12cvs91 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__2_Sep_2004_20_37_35_-0400_Og9_oYW87G_wdmmv"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__2_Sep_2004_20_37_35_-0400_Og9_oYW87G_wdmmv
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thursday September  2 at 05:02pm
Horst von Brand <vonbrand@inf.utfsm.cl> wrote:

> grub can't handle ReiserFS.

Works for me: Debian with stripped-down (non-initrd) 2.6.8.1, root and
home are reiserfs. No other filesystem types..

jkoenig@note:~$ apt-cache policy grub
grub:
  Installed: 0.95+cvs20040624-8
<snip>
jkoenig@note:~$ mount
/dev/hda1 on / type reiserfs (rw)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
tmpfs on /dev/shm type tmpfs (rw)
usbfs on /proc/bus/usb type usbfs (rw)
/dev/hda5 on /home type reiserfs (rw)
/dev/hda6 on /home/jkoenig/mp3 type reiserfs (rw)
jkoenig@note:~$
-- 
-johann koenig
Today is Setting Orange, the 26th day of Bureaucracy in the YOLD 3170
My public pgp key: http://mental-graffiti.com/pgp/

--Signature=_Thu__2_Sep_2004_20_37_35_-0400_Og9_oYW87G_wdmmv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBN7zSPzcAmxzfQF0RAlKFAJ4h9YH+KFu0oxRsuRbad2P6EHuMJQCdH1ca
d/f7gAJhlTPw+495ZqZYId8=
=Sw2c
-----END PGP SIGNATURE-----

--Signature=_Thu__2_Sep_2004_20_37_35_-0400_Og9_oYW87G_wdmmv--
