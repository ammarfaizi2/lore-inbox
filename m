Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbRGGBOd>; Fri, 6 Jul 2001 21:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264780AbRGGBOY>; Fri, 6 Jul 2001 21:14:24 -0400
Received: from 19-LASP-X4.red.retevision.es ([62.174.194.19]:896 "HELO
	jaya.dyndns.org") by vger.kernel.org with SMTP id <S264724AbRGGBOM>;
	Fri, 6 Jul 2001 21:14:12 -0400
Date: Sat, 7 Jul 2001 02:13:56 +0100
From: linuxx <linuxx@eresmas.net>
To: kernel <linux-kernel@vger.kernel.org>
Subject: Hi all, a strange full lock in SMP-kernel 2.4.6 and 2.4.5 
Message-ID: <20010707021356.A2232@eresmas.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux jaya 2.4.6-xfs 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=es_ES
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Well Full lock in 2.4.5 and .6 when in a SMP intel p III 500mhz when i try =
to print any file in a epson 760 usb and parport
printer. =20
I put in antecedents . With 2.4.3 and before the printer via usb or partpor=
t print ok . In 2.4.5-6 when i try to send
anything to /dev/usb/lp0 like cat a.txt > /dev/usb/lp0 the system fail or i=
f i do in lpr same . I have no problem if i use parport whit the sames kern=
els .I have all right configured. With the same computer in other distribut=
ion .Same kernel =3D same lock .Of course the LPRng and gcc are=20
all compiled in this machine and work right for months , both stables versi=
ons.I put the only trace y can get for the lock.
I hope help something for any other thing i not subscribed to kernel list s=
o i like to know any answer you can give. THANKS

CPU:    0
EIP:    0010:[<d084acd1>]
EFLAGS: 00000086
eax: cd747600  ebx: cd1d42a0  ecx: 00000001  edx: cd747600
esi: cd1d41fc  edi: 00000000  ebp: 00000004  esp: cd077f34
ds: 0018  es: 0018  ss:0018
Process cat (pid: 378, stackpage=3Dcd077000)
Stack: 0000017a 00000000 00000005 00000000 00000206 cd1d41a0 cd8f0000 00000=
000
       00000004 d0837aac cd1d41fc d084e411 cd1d41fc 00000000 cdec8c60 fffff=
fea
       00000000 00000004 c013a1c6 cdec8c60 0804c860 00000004 cdec8c80 00000=
025

Call Trace: [<013a1c6>] [<c0106ea7>]
Code: 80 7b 24 00 f3 90 7e f8 e9 e0 d0 ff ff 80 bf 80 00 00 00 00
console shuts up ...
<unfinished ...>
+++ killed by SIGSEGV +++
	     =20


--=20

Lee y algo aprender=E1s:

#----------------------------------------------------------------------
I used to think romantic love was a neurosis shared by two, a supreme
foolishness.  I no longer thought that.  There's nothing foolish in
loving anyone.  Thinking you'll be loved in return is what's foolish.
		-- Rita Mae Brown
#----------------------------------------------------------------------


 Luis Toro Teijeiro                                       THANKS FOR YOUR T=
IME.

               ()
               (o_|||
A=D1O 3021 del   //\ |   demoniaco.
            <<-V_/_|=20

ICQ : 42466380
pasate por http://www.gulic.org  y veras Canarias y los linuxeros
http://jaya.dyndns.org  ------pagina personal
Firma gnupg disponible en https://jaya.dyndns.org/linux/GNUPG/
GnupgFingerprint: 8F06 3E9A F610 89BF 0B09  3DEB 0C7E 9AE1 6CE0 B251=20
                              Windows Where do you want to go today?
                              MacOS   Where do you want to be tomorrow?
                              Linux           Are you coming, or what?
   =20

   =20

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7RmJUDH6a4WzgslERAlkRAJ9Lg/ZIpZdS4HXvy9We7w6TuL1XlQCeNCZ6
svHJjMHdNolPNYZKpcs6rag=
=fLMY
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
