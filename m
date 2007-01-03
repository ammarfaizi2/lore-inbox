Return-Path: <linux-kernel-owner+w=401wt.eu-S1750982AbXACSYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbXACSYJ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 13:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbXACSYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 13:24:09 -0500
Received: from 203-206-170-37.perm.iinet.net.au ([203.206.170.37]:37252 "EHLO
	bastard.youngs.au.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751001AbXACSYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 13:24:07 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 13:24:07 EST
From: Steve Youngs <steve@youngs.au.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       Vivek Goyal <vgoyal@in.ibm.com>, Jean Delvare <khali@linux-fr.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@suse.de>
Subject: Re: 2.6.20-rc3: known unfixed regressions
Organization: Linux Users - Fanatics Dept.
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
	<20070102191606.GU20714@stusta.de>
X-Face: #/1'_-|5_1$xjR,mVKhpfMJcRh8"k}_a{EkIO:Ox<]@zl/Yr|H,qH#3jJi6Aw(Mg@"!+Z"C
 N_S3!3jzW^FnPeumv4l#,E}J.+e%0q(U>#b-#`~>l^A!_j5AEgpU)>t+VYZ$:El7hLa1:%%L=3%B>n
 K{^jU_{&
Mail-Copies-To: never
X-X-Day: Only 2430507 days till X-Day.  Got Slack?
X-URL: <http://www.youngs.au.com/~steve/>
X-Request-PGP: <http://www.youngs.au.com/~steve/pgp/sryoungs.asc>
X-OpenPGP-Fingerprint: 1659 2093 19D5 C06E D320  3A20 1D27 DB4B A94B 3003
X-Now-Playing: #1 Zero --- [Audioslave]
X-Discordian-Date: Prickle-Prickle, the 4th day of Chaos, 3173. 
X-Attribution: SY
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>, Linus Torvalds
	<torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel
	Mailing List <linux-kernel@vger.kernel.org>, Segher Boessenkool
	<segher@kernel.crashing.org>, Vivek Goyal <vgoyal@in.ibm.com>, Jean
	Delvare <khali@linux-fr.org>, Eric W. Biederman
	<ebiederm@xmission.com>, Andi Kleen <ak@suse.de>
Date: Thu, 04 Jan 2007 04:15:02 +1000
In-Reply-To: <20070102191606.GU20714@stusta.de> (Adrian Bunk's message of
	"Tue\, 2 Jan 2007 20\:16\:06 +0100")
Message-ID: <microsoft-free.87bqlgvuxl.fsf@youngs.au.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) SXEmacs/22.1.7 (De Lorean, linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

* Adrian Bunk <bunk@stusta.de> writes:

  > Subject    : kernel immediately reboots
  > References : http://lkml.org/lkml/2007/1/2/15
  > Submitter  : Steve Youngs <steve@youngs.au.com>
  > Status     : unknown

I'm very happy to report that this is now fixed for me.  See commit
c6b33cc4e9882b44f1b0c36396f420076e04a4e2.

Thanks very much for the fast response and fix.

=2D-=20
|---<Steve Youngs>---------------<GnuPG KeyID: A94B3003>---|
|                   Te audire no possum.                   |
|             Musa sapientum fixa est in aure.             |
|----------------------------------<steve@youngs.au.com>---|

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: The SXEmacs Project <http://www.sxemacs.org>
Comment: Eicq - The SXEmacs ICQ Client <http://www.eicq.org/>

iEYEARECAAYFAkWb8qcACgkQHSfbS6lLMAMi7wCeLisiXNhaJZjtBRyjR2kTbSf6
9esAoJfc/j3hSe6ul5qc/h4AgS7TKYCu
=k8kW
-----END PGP SIGNATURE-----
--=-=-=--
