Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266246AbUFZPLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266246AbUFZPLW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 11:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267174AbUFZPLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 11:11:21 -0400
Received: from nuit.ca ([66.11.160.83]:4001 "EHLO smtp.nuit.ca")
	by vger.kernel.org with ESMTP id S266246AbUFZPLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 11:11:14 -0400
Date: Sat, 26 Jun 2004 15:11:10 +0000
From: simon@nuit.ca
To: linux-kernel@vger.kernel.org
Subject: Cannot access '/dev/pts/292': Value too large for defined data type
Message-ID: <20040626151108.GA8778@nuit.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
X-Operating-System: Debian GNU/Linux
X-GPG-Key-Server: x-hkp://subkeys.pgp.net
User-Agent: Mutt/1.5.6+20040523i
X-Scan-Signature: smtp.nuit.ca 1BeEpi-0002bX-R6 0812523dd2b651dd1daa603b0dc5d01e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


hello,

whenever i try open a new pseudo-pty, i get a similar message to=20
the one in the subject, and one like "fstat: Value too large for defined da=
ta
type" if i open an xterm. the error mentioned in the subject is one i
get if i try to re-open a screen session.

i cannot open a screen session in X then, and only on the console (i use
screen to be able to move my shell sessions from console to X and back).

this started happening when i opened my current X session.

what can i do to remedy this?


output from scripts/ver_linux, /proc/cpuinfo, and others below. i am not=20
subscribed to the list.


----- scripts/ver_linux (slightly formatted): -----
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
Linux pylon 2.6.7-1 #1 Sat Jun 19 16:43:25 UTC 2004 ppc GNU/Linux
=20
Gnu C                  3.3.4
Gnu make               3.80
binutils               2.14.90.0.7
util-linux             2.12
mount                  2.12
module-init-tools      3.1-pre2
e2fsprogs              1.35
xfsprogs               2.6.11
quota-tools            3.12.
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         snd_powermac snd_pcm_oss snd_mixer_oss snd_pcm snd_t=
imer snd deflate=20
	des xfrm_user ipcomp esp4 ah4 mach64 sha1 agpgart arc4 nfsd exportfs i2c_k=
eywest cls_fw=20
	cls_route cls_u32 cls_rsvp6 cls_rsvp cls_tcindex sch_teql sch_tbf sch_sfq =
sch_red sch_prio=20
	sch_hfsc sch_htb sch_gred sch_ingress sch_csz sch_cbq sch_dsmark ip6table_=
mangle=20
	ip6table_filter ip6t_rt ip6t_ipv6header ip6t_hl ip6t_hbh ip6t_frag ip6t_es=
p ip6t_dst=20
	ip6t_ah ip6t_owner ip6t_mark ip6t_mac ip6t_limit ip6t_length ip6t_multipor=
t ip6t_MARK=20
	ip6t_LOG ip6t_eui64 ip6_tables ipt_SAME ipt_NETMAP ipt_iprange ipt_CLASSIF=
Y=20
	ip_nat_snmp_basic ip_nat_ftp ip_conntrack_ftp ip_nat_irc ip_conntrack_irc=
=20
	iptable_mangle iptable_filter ipt_ttl ipt_tos ipt_tcpmss ipt_state ipt_pkt=
type=20
	ipt_owner ipt_multiport ipt_mark ipt_mac ipt_recent ipt_limit ipt_length i=
pt_helper=20
	ipt_esp ipt_ecn ipt_dscp ipt_conntrack ipt_ah ipt_ULOG ipt_TOS ipt_TCPMSS =
ipt_REJECT=20
	ipt_REDIRECT ipt_MASQUERADE iptable_nat ip_conntrack ipt_MARK ipt_LOG ipt_=
ECN ipt_DSCP=20
	ip_tables snd_page_alloc sha256 cryptoloop twofish softdog nls_cp437 nls_c=
p863 tun=20
	bsd_comp ppp_async ppp_deflate zlib_deflate pppoe pppox ppp_generic slhc i=
pddp=20
	cdrom isofs zlib_inflate hfs hfsplus nfs lockd sunrpc 3c59x mace=20
----------

----- /proc/cpuinfo: -----
processor       : 0
cpu             : 604e
clock           : 185MHz
revision        : 2.4 (pvr 0009 0204)
bogomips        : 356.35
machine         : Power Macintosh
motherboard     : AAPL,8500 MacRISC
detected as     : 16 (PowerMac 8500/8600)
pmac flags      : 00000000
L2 cache        : 512K unified
memory          : 448MB
pmac-generation : OldWorld
----------

----- /proc/ioports: -----                                                 =
                                 =20
00000000-007fffff : /bandit@F2000000
  00000000-000000ff : 0000:00:0f.0
  00000400-000004ff : 0000:00:0d.0
  00000800-0000087f : 0000:00:0e.0
    00000800-0000087f : 0000:00:0e.0
ff7fe000-ffffdfff : /chaos@F0000000
----------

----- /proc/iomem: -----
80000000-8fffffff : /bandit@F2000000
  80800000-8080007f : 0000:00:0e.0
  80801000-80801fff : 0000:00:0f.0
    80801000-80801fff : aic7xxx
  80802000-80802fff : 0000:00:0d.0
  81000000-81ffffff : 0000:00:0d.0
    81000000-81ffffff : atyfb
90000000-9fffffff : /chaos@F0000000
  90000000-9000ffff : 0001:01:0b.0
    90001000-90001fff : controlfb regs
  94000000-97ffffff : 0001:01:0b.0
    94000000-97ffffff : controlfb
f1000000-f1ffffff : /chaos@F0000000
  f1000000-f10003ff : 0001:01:0d.0
f3000000-f3ffffff : /bandit@F2000000
  f3000000-f301ffff : 0000:00:10.0
    f3000000-f301ffff : 0.f3000000:gc
      f3008000-f30080ff : 0.00010000:53c94
        f3008000-f30080ff : mac53c94
      f3008100-f30081ff : 0.00015000:swim3
      f3008200-f30082ff : 0.00011000:mace
        f3008200-f30082ff : mace
      f3008300-f30083ff : 0.00011000:mace
        f3008300-f30083ff : mace
      f3008400-f30084ff : 0.00013020:ch-a
        f3008400-f30084ff : pmac_zilog
      f3008500-f30085ff : 0.00013020:ch-a
        f3008500-f30085ff : pmac_zilog
      f3008600-f30086ff : 0.00013000:ch-b
        f3008600-f30086ff : pmac_zilog
      f3008700-f30087ff : 0.00013000:ch-b
        f3008700-f30087ff : pmac_zilog
      f3008800-f30088ff : 0.00014000:awacs
        f3008800-f30088ff : awacs- Tx DMA
      f3008900-f30089ff : 0.00014000:awacs
        f3008900-f30089ff : awacs- Rx DMA
      f3008a00-f3008aff : 0.00018000:mesh
        f3008a00-f3008aff : mesh
      f3010000-f30100ff : 0.00010000:53c94
        f3010000-f30100ff : mac53c94
      f3011000-f3011fff : 0.00011000:mace
        f3011000-f3011fff : mace
      f3013000-f301301f : 0.00013000:ch-b
        f3013000-f301301f : pmac_zilog
      f3013020-f301303f : 0.00013020:ch-a
        f3013020-f301303f : pmac_zilog
      f3014000-f3014fff : 0.00014000:awacs
        f3014000-f3014fff : awacs
      f3015000-f3015fff : swim3
        f3015000-f3015fff : 0.00015000:swim3
      f3016000-f3017fff : 0.00016000:via-cuda
        f3016000-f3017fff : via-cuda
      f3018000-f30180ff : 0.00018000:mesh
        f3018000-f30180ff : mesh
      f301b000-f301bfff : controlfb cmap
      f301c000-f301c03f : 0.0001c000:sixty6
      f301d000-f301d00f : 0.0001d000:nvram
      f301f000-f301f1ff : 0.0001d000:nvram
f8000000-f80007ff : hammerhead
----------

--=20
Puritanism: The haunting fear that someone, somewhere may be happy.

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQGVAwUBQN2SCmqIeuJxHfCXAQIvVAv+Jp8u7eeHq3Q1WHNHxZ9xtEJpKbO3xOo4
wXbdSpnlKm8iRIXGDeRjRxIKCKWyQ5/YWWWMd8ftps6L0Iue1SN6lRpiBchebGJf
3qswimOTm7HXuFMe859pdWjIVPn9/KkuJ09ynEradPMMnmdcTnCuxES6OwaJso95
WXZllUq2BAuq9eV5UodpgSHYtU6EBnKDDrvu2YT6t9xPvk6mRnEFIzNZcWCgh1hm
zw7zUncyB1o4Wi0Ma/y9Vw2IiSt7Q6oKDXARkFvJkC2CwCRXA3fmNKx/TppWK/lh
hvBhGHPWg/Enma3mdKOY3BtMeTNiJ1gQulJEJDuiHoi3ZqnCfU/0700XQvIKhz08
r++G7J335sJ3tETgEqNEZqcraLS7Zn25AZS+NqwTdvsgh23qv1Nc5AMGxggoPl7G
aPxAs5ELgfu6ToNZyiS5GT7qxxoNmDbTkGJZDKIKSHyHYyYYpznUUrAlhZJhJcZz
iU6uykZ6vBKgD3qidAyYq3LyKkKM3q+M
=hEuR
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
