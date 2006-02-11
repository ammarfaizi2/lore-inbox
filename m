Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWBKVSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWBKVSj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 16:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWBKVSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 16:18:38 -0500
Received: from natipslore.rzone.de ([81.169.145.179]:59563 "EHLO
	natipslore.rzone.de") by vger.kernel.org with ESMTP id S964798AbWBKVSi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 16:18:38 -0500
Date: Sat, 11 Feb 2006 21:47:34 +0100
From: Nico Golde <nico@ngolde.de>
To: linux-kernel@vger.kernel.org
Subject: Getting cpu frequency
Message-ID: <20060211204733.GA7813@ngolde.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
X-Editor: VIM - Vi IMproved 6.4 (2005 Oct 15, compiled Jan 15 2006 19:02:40)
X-Mailer: Mutt-ng http://www.muttng.org
X-Operating-System: Debian GNU/Linux sid
X-My-Homepage: http://www.ngolde.de
User-Agent: mutt-ng/devel-r556 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
at the moment I try to get the current cpu frequency via=20
using the cpufreq_get() function defined in linux/cpufreq.h.
Can someone point me to the headers I have to include to let=20
this work because just doing #include <linux/cpufreq.h>=20
results in a bunch of errors:
[...]=20
In file included from /usr/include/linux/cpu.h:22,
                 from cpu.c:2:
/usr/include/linux/sysdev.h:31: error: field 'drivers' has incomplete type
/usr/include/linux/sysdev.h:35: error: syntax error before 'pm_message_t'
/usr/include/linux/sysdev.h:37: error: field 'kset' has incomplete type
/usr/include/linux/sysdev.h:50: error: field 'entry' has incomplete type
/usr/include/linux/sysdev.h:54: error: syntax error before 'pm_message_t'
/usr/include/linux/sysdev.h:69: error: syntax error before 'u32'
/usr/include/linux/sysdev.h:72: error: syntax error before '}' token
/usr/include/linux/sysdev.h:79: error: field 'attr' has incomplete type
/usr/include/linux/sysdev.h:80: error: syntax error before 'ssize_
[...]=20
Using 2.6.14.
Regards Nico
P.S. Please CC me, I am not subsribed, thanks

--=20
Nico Golde - JAB: nion@jabber.ccc.de | GPG: 0x73647CFF
http://www.ngolde.de | http://www.muttng.org | http://grml.org
Forget about that mouse with 3/4/5 buttons -
gimme a keyboard with 103/104/105 keys!

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD7k1lHYflSXNkfP8RAq9nAKCUaSjI5HItvwD51vQPTqCxnPv55ACff7sL
kx39EMtD5SbMgTuYTkDV110=
=YL72
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
