Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264591AbRFPIO5>; Sat, 16 Jun 2001 04:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264592AbRFPIOs>; Sat, 16 Jun 2001 04:14:48 -0400
Received: from odin.sinectis.com.ar ([216.244.192.158]:33284 "EHLO
	mail.sinectis.com.ar") by vger.kernel.org with ESMTP
	id <S264591AbRFPIOa>; Sat, 16 Jun 2001 04:14:30 -0400
Date: Sat, 16 Jun 2001 05:14:56 -0300
From: John R Lenton <john@grulic.org.ar>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Few thoughts about CML2 and kernel configuration
Message-ID: <20010616051456.B562@grulic.org.ar>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0106160026320.7462-100000@presario>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0106160026320.7462-100000@presario>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 16, 2001 at 11:22:27AM +0600, Anuradha Ratnaweera wrote:
> - The feeling is much similar to that of using lynx (especially using
>   left-arrow). It would be very nice if pressing right-arrow gives the
>   same effect as pressing enter.

that's what the help says it *should* do. Try this:

----
--- cmlconfigure.py~    Sun Jun 10 13:05:58 2001
+++ cmlconfigure.py     Sat Jun 16 05:10:32 2001
@@ -1478,7 +1478,7 @@
                     cmd =3D self.help_popup("EXITCONFIRM", (lang["REALLY"]=
,), beep=3D0)
                     if cmd =3D=3D ord('q'):
                         break
-                elif cmd in (curses.KEY_ENTER,ord(' '),ord('\r'),ord('\n')=
) :
+                elif cmd in (curses.KEY_ENTER,curses.KEY_RIGHT,ord(' '),or=
d('\r'),ord('\n')) :
                     # Operate on the current object
                     if sel_symbol.type =3D=3D "message":
                         curses.beep()
----

--=20
John Lenton (john@grulic.org.ar) -- Random fortune:
This wasn't just plain terrible, this was fancy terrible.  This was terrible
with raisins in it.
		-- Dorothy Parker

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7KxWAgPqu395ykGsRAn7dAJoCWoqieySrmpsfHzwjtGiZjb3D4ACeJlse
0MbBex92qXBOFoDbOf52EdQ=
=mkDt
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
