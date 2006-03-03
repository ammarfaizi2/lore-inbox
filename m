Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWCCNVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWCCNVM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 08:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWCCNVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 08:21:12 -0500
Received: from daemo06.udag.de ([62.146.33.130]:54735 "EHLO mail.udag.de")
	by vger.kernel.org with ESMTP id S1750817AbWCCNVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 08:21:12 -0500
From: Alexander Mieland <dma147@linux-stats.org>
Organization: Linux Statistics
To: LKML <linux-kernel@vger.kernel.org>
Subject: how to find out which module was built by which .config variables?
Date: Fri, 3 Mar 2006 14:20:42 +0100
User-Agent: KMail/1.9
X-Face: "[.(DJ7n08,b3KjixLk+L+kK%5O{[xod@~Mo/'mqsUN#[CVc-:2Bkl1K9W)=?utf-8?q?JoO=7C=2EtD=26N6y=0A=09V=3B=26ah=27=3Fox=3AmGfop=3AC=5BO=60=2E8?=
 =?utf-8?q?3Qk-vk=5FX?=@=glws(}Ts]sVCi'9Mw~Wm4nIqVQ)
 =?utf-8?q?b=27qvcxbNX=5E=7B=0A=09kG=3F=3DK=2EOy?="cn{u.05=LxYh{l^kU?Y,lu5rG?@~M_3xmKjrPm:
X-Count: Registered Linux-User #249600
X-ePatents: NO!!!!
X-Motto: Give drugs no chance!
X-Kernel: 2.6.15-ck3--r1-fb-my4 SMP
X-Cpu: 2x Intel Pentium 2,6 GHz with HT
X-Distribution: Gentoo 2005.1-r1
X-Homepage: http://www.linux-stats.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart51897807.RaIMYByX7u";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603031420.46801.dma147@linux-stats.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart51897807.RaIMYByX7u
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

I need to create a database with configuration options (the ones=20
in .config) and the resulting kernel modules.

Is there any simple possibility (with bash and its applications) to find=20
out, which kernel modules will be built by which .config options? I know=20
that there are also many dependencies between the options and the modules=20
and I want to add them to the database too. The dependencies can be found=20
out with the Kconfig files, I think.

I've already looked into the source files of some modules, but I can not=20
find any commonalities which would make it easy to find the module-name=20
which will be build.

I've found some stuff like this:
#define DRIVER_NAME	"8139too"
or things linke:
#define <something>_MODULES_NAME	"some string which seems to be the=20
descriptive name"

But this doesn't really help... :(

Sincerely

Alexander Mieland

=2D-=20
Alexander 'dma147' Mieland                   2.6.15-ck3-r1-fb-my4 SMP
=46nuPG-ID: 27491179                      Registered Linux-User #249600
http://blog.linux-stats.org                http://www.linux-stats.org
http://www.mieland-programming.de          http://www.php-programs.de

--nextPart51897807.RaIMYByX7u
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBECEKuCYRNlSdJEXkRAjuwAJ0a2xQx6+c09fjjWGfipE1DGM77EQCfQ1xR
H1yR1Icpt1trDjHOnih4xDA=
=oLAG
-----END PGP SIGNATURE-----

--nextPart51897807.RaIMYByX7u--
