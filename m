Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUKRXWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUKRXWf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 18:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbUKRXUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 18:20:43 -0500
Received: from smtp.kisikew.org ([66.11.160.83]:22144 "EHLO smtp.nuit.ca")
	by vger.kernel.org with ESMTP id S262997AbUKRXR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 18:17:58 -0500
Date: Thu, 18 Nov 2004 18:17:48 -0500
From: simon@nuit.ca
To: linux-kernel@vger.kernel.org
Subject: follow-up to: OOPS in tulip on 2.6.10-rc2-bk2
Message-ID: <20041118231748.GB6228@nuit.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
X-Operating-System: Debian GNU/Linux
X-GPG-Key-Server: x-hkp://subkeys.pgp.net
User-Agent: Mutt/1.5.6+20040907i
X-Scan-Signature: smtp.nuit.ca 1CUvXA-0001gJ-F7 a4880918733d98e6d99164340cda9604
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


ok, this is my boot sequence when i boot to the current testing kernel,
2.6.10-rc2-bk3:

Thu Nov 18 22:57:56 2004:      tulip: can't be loaded
Thu Nov 18 22:57:56 2004: missing kernel or user mode driver tulip
Thu Nov 18 22:57:56 2004:      tulip: already loaded
Thu Nov 18 22:57:56 2004:    pci      [success]
Thu Nov 18 22:57:56 2004:    usb
Thu Nov 18 22:57:57 2004:    usb      [success]
Thu Nov 18 22:57:57 2004: done
Thu Nov 18 22:57:57 2004: Running 0dns-down to make sure resolv.conf is ok.=
=2E.done.
Thu Nov 18 22:57:57 2004: /dev/shm/network/...Initializing: /etc/network/if=
state.
Thu Nov 18 22:57:57 2004: Setting up IP spoofing protection: rp_filter.
Thu Nov 18 22:57:57 2004: Enabling packet forwarding...done.
Thu Nov 18 22:57:57 2004: Configuring network interfaces...SIOCSIFADDR: Fil=
e exists
Thu Nov 18 22:57:57 2004: Failed to bring up lo.
Thu Nov 18 22:57:58 2004: 2000::/3: Resolver Error 0 (no error)
Thu Nov 18 22:57:58 2004: Failed to bring up eth0.
Thu Nov 18 22:57:58 2004: SIOCSIFADDR: File exists
Thu Nov 18 22:57:58 2004: Failed to bring up eth0:0.
Thu Nov 18 22:57:58 2004: SIOCSIFADDR: File exists
Thu Nov 18 22:57:58 2004: Failed to bring up eth0:3.
Thu Nov 18 22:57:59 2004: SIOCSIFADDR: No such device
Thu Nov 18 22:57:59 2004: eth1: ERROR while getting interface flags: No suc=
h device
Thu Nov 18 22:57:59 2004: SIOCSIFNETMASK: No such device
Thu Nov 18 22:57:59 2004: SIOCSIFBRDADDR: No such device
Thu Nov 18 22:57:59 2004: eth1: ERROR while getting interface flags: No suc=
h device
Thu Nov 18 22:57:59 2004: eth1: ERROR while getting interface flags: No suc=
h device
Thu Nov 18 22:57:59 2004: Failed to bring up eth1.
Thu Nov 18 22:58:00 2004: Plugin rp-pppoe.so loaded.
Thu Nov 18 22:58:00 2004: RP-PPPoE plugin version 3.3 compiled against pppd=
 2.4.2
Thu Nov 18 22:58:00 2004: done.
Thu Nov 18 22:58:00 2004: Starting portmap daemon: portmap.
Thu Nov 18 22:58:01 2004: ^[]RSetting up general console font... ^[%G^[[9;3=
0]^[[14;30]
Thu Nov 18 22:58:07 2004: Setting the System Clock using the Hardware Clock=
 as reference...
Thu Nov 18 22:58:08 2004: System Clock set. Local time: Thu Nov 18 22:58:08=
 UTC 2004
Thu Nov 18 22:58:08 2004:
Thu Nov 18 22:58:08 2004: Running ntpdate to synchronize clock.
Thu Nov 18 22:58:08 2004: Initializing random number generator...done.
Thu Nov 18 22:58:08 2004: Recovering nvi editor sessions... done.
Thu Nov 18 22:58:09 2004: Give root password for maintenance
Thu Nov 18 22:58:09 2004: (or type Control-D to continue):
Thu Nov 18 22:58:19 2004: ^[[0m^[[27m^[[24m^[[J^[[1m^[[36m^[[11m^[[1m^[[34m=
^[[10m(^[[1m^[[32m^[[7mROOT^[[27m^[[1m^[[32m@pylon:console^[[1m^[[34m)^[[11=
m^[[1m^[[36m^[[1m^[[34m^[[10m(^[[1m^[[35m~^[[1m^[[34m)^[[11m^[[1m^[[36m^[[1=
0m
Thu Nov 18 22:58:19 2004: ^[[11Gpoffm^[[11m^[[1m^[[34m^[[10m(^[[1m^[[33m22:=
58^[[34m:^[[1m^[[31m#^[[1m^[[34m)^[[11m^[[10m^[[1m^[[36m^[[11m^[[10m^[[0;10=
m ^[[K^[[116G ^[[1m^[[36m^[[11m^[[1m^[[34m^[[10m(^[[1m^[[33mThu,Nov18^[[1m^=
[[34m)^[[11m^[[1m^[[36m^[[10m^[[0;10m
Thu Nov 18 22:58:27 2004: ^[[0m^[[27m^[[24m^[[J^[[1m^[[36m^[[11m^[[1m^[[34m=
^[[10m(^[[1m^[[32m^[[7mROOT^[[27m^[[1m^[[32m@pylon:console^[[1m^[[34m)^[[11=
m^[[1m^[[36m^[[1m^[[34m^[[10m(^[[1m^[[35m~^[[1m^[[34m)^[[11m^[[1m^[[36m^[[1=
0m
Thu Nov 18 22:58:27 2004:

please note the poff in all the escape codes ^^^^^^^ second line of
junk, after "Thu Nov 18 22:58:19 2004: ^[[11G"=20

that's where it oopses and panics, after pressing x<return> in xmon. i got =
some of the oops output:

snmp6_unregister_dev
in6_dev_finish_destory
ip6_dst_destroy

were some of the symbols (?) i managed to get before it rebooted on me
(i have panic set to 60 for s/w watchdog).



--=20
Cold pizza and cold coffee, second best thing to cold pizza and warm beer.

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQGVAwUBQZ0tm2qIeuJxHfCXAQKe5wwAkb13N9Jj+/QtcwjIKALULKDELUgW84F6
1K9xn6oHANNktxQPeqUPHzKTWe39hd0vqPSG/j6BWHtbsGmQiJfevCckxZLnzSyE
cUpo34JEXDpv3oktn98lQMOQFWwfz/aUxJj5nS7siuNv6vQcqo5QIIptfVCHlcUt
2NFuV7TqIyP5Xm5feoHBPPhl7BGNYAmi8uP67v8KXWjYBS6iFMQhISTEK/f1Wfbv
Fy9jnMNuKYM4xyb8jhEjLZbMVhRMWorBPjO+zhEK+vf8KU3RzVFwxm07Zdg9rqTC
7avPa8PQPJSSEH1lWiv8+VCrJlB6gGXTLCiZgtHjZD15SXkKVmd3BK6mSAVeH/gz
HVUTwFERiS30GsAdMMVBG4zWnghtyGhUs7U2Ljhg3YO4Mnc9U5M/QiHGCcHimagU
0gadIbLimUK6MNJgirdFomv4ioATp3hv3YwOvyINbyWu3rSPdgqBqDf+KOSw0NUH
HTX0Q8E2xK1itxen6UzEoF0b0T4AjRSV
=FVTe
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
