Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965169AbVJUVXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965169AbVJUVXq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 17:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVJUVXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 17:23:46 -0400
Received: from CPE-61-9-212-151.qld.bigpond.net.au ([61.9.212.151]:2367 "EHLO
	bastard.youngs.au.com") by vger.kernel.org with ESMTP
	id S1751150AbVJUVXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 17:23:45 -0400
From: Steve Youngs <steve@youngs.au.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Ken Moffat <zarniwhoop@ntlworld.com>
Subject: Re: 2.6.13.4 After increasing RAM, I'm getting Bad page state at prep_new_page
Keywords: memtest86,memory,ram,hardware
Organization: Linux Users - Fanatics Dept.
References: <microsoft-free.877jc9jzwy.fsf@youngs.au.com>
	<Pine.LNX.4.63.0510191730570.23833@deepthought.mydomain>
X-Face: #/1'_-|5_1$xjR,mVKhpfMJcRh8"k}_a{EkIO:Ox<]@zl/Yr|H,qH#3jJi6Aw(Mg@"!+Z"C
 N_S3!3jzW^FnPeumv4l#,E}J.+e%0q(U>#b-#`~>l^A!_j5AEgpU)>t+VYZ$:El7hLa1:%%L=3%B>n
 K{^jU_{&
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>, steve@youngs.au.com
X-X-Day: Only 2430946 days till X-Day.  Got Slack?
X-URL: <http://www.youngs.au.com/~steve/>
X-Request-PGP: <http://www.youngs.au.com/~steve/pgp/sryoungs.asc>
X-OpenPGP-Fingerprint: 1659 2093 19D5 C06E D320  3A20 1D27 DB4B A94B 3003
X-Discordian-Date: Setting Orange, the 3rd day of The Aftermath, 3171. 
X-Attribution: SY
Date: Sat, 22 Oct 2005 07:23:14 +1000
In-Reply-To: <Pine.LNX.4.63.0510191730570.23833@deepthought.mydomain> (Ken
	Moffat's message of "Wed, 19 Oct 2005 17:54:20 +0100 (BST)")
Message-ID: <microsoft-free.87pspybm4d.fsf@youngs.au.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) SXEmacs/22.1.3 (BMW, linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

* Ken Moffat <zarniwhoop@ntlworld.com> writes:

  > On Thu, 20 Oct 2005, Steve Youngs wrote:
  >>=20
  >> RAM.  But I've run memtest86 (version 3.2) over the RAM and no errors
  >> were found.

  >  Steve,

  > this is almost certainly a hardware problem.  I'm not saying that the
  > RAM is actually defective, it could be that the motherboard doesn't
  > reliably support that much memory, or even a weak powersupply.

  > I prefer to use memtest86+ for recent hardware, but I'm sure
  > memtest86 can find errors if you give it long enough (on a 1.8GHz
  > athlon64 with a mere 2GB of memory, several hours were needed -
  > the memory was good, but the mobo couldn't drive that much at
  > full speed).

I gave memtest86+ a shot, and after about 18 hours it came up with...

  Test:            8
  Pass:            7
  Failing Address: 00008072bf0 - 128.1MB
  Good:            00000000
  Bad:             00000100
  Err-Bits:        00000100
  Count:           1

  >  3GB sounds an awful lot for an athlon - 2x1GB and 2x512MB, I suppose.=
=20

3x1GB

  >  Of course, if it's a PSU problem related to excessive power to memory =
+=20
  > disk(s) + graphics card, memtest86 is unlikely to trigger it.

And to track _that_ down I'll have to play "mix'n'match" with the
hardware.  Something that I can't do right now (financially, and,
time). :-(

Sounds like I'm just going to have to put up with it for the time
being.

Thanks anyway, Ken.

=2D-=20
|---<Steve Youngs>---------------<GnuPG KeyID: A94B3003>---|
|                   Te audire no possum.                   |
|             Musa sapientum fixa est in aure.             |
|----------------------------------<steve@youngs.au.com>---|

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Eicq - The XEmacs ICQ Client <http://eicq.sf.net/>

iEYEABECAAYFAkNZXEIACgkQHSfbS6lLMAOfDACfQeGHdmoM21fERuP79frYk8mD
blgAnR273N4UwEv2FzhBkXG6YbWNJxRN
=Bkf/
-----END PGP SIGNATURE-----
--=-=-=--
