Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129716AbRAWNvI>; Tue, 23 Jan 2001 08:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129610AbRAWNut>; Tue, 23 Jan 2001 08:50:49 -0500
Received: from mout03.kundenserver.de ([195.20.224.218]:55076 "EHLO
	mout03.kundenserver.de") by vger.kernel.org with ESMTP
	id <S129759AbRAWNui>; Tue, 23 Jan 2001 08:50:38 -0500
X-Sieve: cmu-sieve 1.3
From: Thomas Kerpe <kerpe@schlund.de>
To: netfilter@us5.samba.org
Subject: Masquerading Portrange in 2.4.0 
Message-ID: <20010123143440.A535@schlund.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-BeenThere: netfilter@lists.samba.org
X-Mailman-Version: 2.0beta6
List-Help: <mailto:netfilter-request@lists.samba.org?subject=help>
List-Post: <mailto:netfilter@lists.samba.org>
List-Subscribe: <http://lists.samba.org/listinfo/netfilter>, <mailto:netfilter-request@lists.samba.org?subject=subscribe>
List-Id: Netfilter discussions <netfilter.lists.samba.org>
List-Unsubscribe: <http://lists.samba.org/listinfo/netfilter>, <mailto:netfilter-request@lists.samba.org?subject=unsubscribe>
List-Archive: http://lists.samba.org/pipermail/netfilter/
Date: Tue, 23 Jan 2001 14:34:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I am wondering about the hard-coded Masquerading Port-Range
in net/ipv4/netfilter/ip_fw_compat_masq.c (kernel 2.4.0)=20
In the 2.2.x Kernel hirarchy the Masquerading Ports could be=20
changed in an include file. It doesnt look so pretty...

 range =3D ((struct ip_nat_multi_range)
                         { 1,
                           {{IP_NAT_RANGE_MAP_IPS|IP_NAT_RANGE_PROTO_SPECIF=
IED,
                             newsrc, newsrc,
                             { htons(61000) }, { htons(65095) } } } });

Greets...=20
Thomas Kerpe


--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6bYhw9jrn3C9VwiMRAjCsAJ0TLIn1WxiEzRhfcGK6Q4Edh6MefwCfUvAz
dcLmwU4XzdVZDS5JVPvkuoc=
=CdOp
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
