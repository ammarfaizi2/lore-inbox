Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281415AbRKPOCy>; Fri, 16 Nov 2001 09:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281418AbRKPOCe>; Fri, 16 Nov 2001 09:02:34 -0500
Received: from t2.redhat.com ([199.183.24.243]:54772 "EHLO
	dhcp-177.hsv.redhat.com") by vger.kernel.org with ESMTP
	id <S281415AbRKPOCb>; Fri, 16 Nov 2001 09:02:31 -0500
Date: Fri, 16 Nov 2001 08:02:18 -0600
From: Tommy Reynolds <reynolds@redhat.com>
To: "ANTHONY DELSORBO" <delsorbo@asc.hpc.mil>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unresolved symbol kiobuf_init for kernel 2.4.9-6
Message-Id: <20011116080218.613b910a.reynolds@redhat.com>
In-Reply-To: <0111151810400C.01205@spt93>
In-Reply-To: <0111151810400C.01205@spt93>
Organization: Red Hat Software, Inc. / Embedded Development
X-Mailer: Sylpheed version 0.6.5cvs3 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$ t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="b=.4uSJ+uqljMw7C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--b=.4uSJ+uqljMw7C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

It was a dark and stormy night.  Suddenly
"ANTHONY DELSORBO" <delsorbo@asc.hpc.mil> began to type furiously:

> I'm attempting to load a module whose code has a call to kiobuf_init.

Don't do that.  Use "alloc_kiobuf()" and "free_kiobuf()" instead.  "Kiobuf_init"
is a worker-bee routine that mere mortals should not use.

---------------------------------------------+-----------------------------
Tommy Reynolds                               | mailto: <reynolds@redhat.com>
Red Hat, Inc., Embedded Development Services | Phone:  +1.256.704.9286
307 Wynn Drive NW, Huntsville, AL 35805 USA  | FAX:    +1.256.837.3839
Senior Software Developer                    | Mobile: +1.919.641.2923

--b=.4uSJ+uqljMw7C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAjv1HHAACgkQWEn3bOOMcuo85ACgmvFWXV+y/taHrH3DRzj9eX/3
mdsAnRsxwi5JDFAS/DWisUECTKKgZqkH
=MBTx
-----END PGP SIGNATURE-----

--b=.4uSJ+uqljMw7C--

