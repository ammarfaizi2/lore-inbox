Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263761AbUHVAZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbUHVAZG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 20:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263962AbUHVAZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 20:25:06 -0400
Received: from mylinuxtime.de ([217.160.170.124]:32169 "EHLO solar.linuxob.de")
	by vger.kernel.org with ESMTP id S263761AbUHVAY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 20:24:59 -0400
From: Christian Hesse <mail@earthworm.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: v2.6.8.1 breaks tspc
Date: Sun, 22 Aug 2004 02:21:34 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <200408212303.05143.mail@earthworm.de> <200408220116.42490.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200408220116.42490.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1476472.CyV98zaydD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200408220221.39178.mail@earthworm.de>
X-AntiVirus: checked by AntiVir Milter 1.0.6; AVE 6.27.0.6; VDF 6.27.0.23
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1476472.CyV98zaydD
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 22 August 2004 00:16, Denis Vlasenko wrote:
> On Sunday 22 August 2004 00:02, Christian Hesse wrote:
> > Hello!
> >
> > Kernel version 2.6.8.1 breaks tspc (Freenet6's Tunnel Server Protocol
> > Client). It tries to connect to the server but waits forever. No proble=
ms
> > with 2.6.7, booted the old kernel and it worked perfectly.
> >
> > Any ideas?
>
> What do you see with tcpdump on both 2.6.7 and 2.6.8.1?

In the config file I've changed template from linux to checktunnel. With=20
kernel 2.6.7 it shows all the options it receives from the server. With=20
2.6.8.1:

root@noname:~# tspc -f /etc/freenet6/tspc.conf -vvv
tspc - Tunnel Server Protocol Client

Loading configuration file

Connecting to server

[now waits until Ctrl-c]

A log of strace can be found at
http://linux.eworm.net/tspc_strace.log
=2D-=20
Christian

--nextPart1476472.CyV98zaydD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBJ+cTlZfG2c8gdSURAhNWAKDbR5PWjzzrwJrZpqIW6vU5xIGjbgCdH1WZ
Z1it52bR1P4yzmwmIoR2uiw=
=dvHD
-----END PGP SIGNATURE-----

--nextPart1476472.CyV98zaydD--
