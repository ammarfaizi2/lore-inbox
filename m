Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbUL1HZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbUL1HZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 02:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbUL1HYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 02:24:43 -0500
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:22951 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262108AbUL1Gqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 01:46:34 -0500
From: tabris <tabris@tabris.net>
To: Vladimir Saveliev <vs@namesys.com>
Subject: Re: kernel BUG at fs/inode.c:1116 with 2.6.10-rc{2-mm4,3-mm1}[repost]
Date: Tue, 28 Dec 2004 01:46:19 -0500
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <200412231923.14444.tabris@tabris.net> <200412241032.02190.tabris@tabris.net> <1103903639.23776.50.camel@tribesman.namesys.com>
In-Reply-To: <1103903639.23776.50.camel@tribesman.namesys.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3050781.V5ZeAGbvfd";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200412280146.27438.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3050781.V5ZeAGbvfd
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 24 December 2004 10:54 am, Vladimir Saveliev wrote:
> Hello
>
> On Fri, 2004-12-24 at 18:31, tabris wrote:
> > On Friday 24 December 2004 3:09 am, Andrew Morton wrote:
> > > tabris <tabris@tabris.net> wrote:
> > > > 	Attached are the BUG reports for 2.6.10-rc2-mm4 (multiple BUG
> > > > reports) and one from 2.6.10-rc3-mm1, plus dmesg from
> > > > 2.6.10-rc3-mm1.
> > >
> > > Are you using quotas?
> >
> > 	Yes, I am using quotas.
> >
> > > What filesystem types are in use?
> >
> > 	I'm using reiserFS and XFS mostly, with one ext2 partition (/boot,
> > mounted -o sync)
>
> Would you please try to reproduce this problem with:
> http://marc.theaimsgroup.com/?l=3Dreiserfs&m=3D110381606727976&q=3Dp3
	Using the patch mentioned above, 14 hours uptime and no BUG yet. more=20
stress testing needed however before I can declare all is well.

	On an unrelated note, enabling lapic (tho my board doesn't seem to have=20
an IO-APIC) causes some prefm/mdkkdm to not start properly.

	Also, w/ or w/o lapic, shutdown freezes on the stopping of CUPS.=20
Everything is still alive, but CUPS never shuts down so I have to use=20
SysRq-B to reboot.

=2D-=20
I thought my people would grow tired of killing.  But you were right,=20
they see it is easier than trading.  And it has its pleasures.  I feel=20
it myself.  Like the hunt, but with richer rewards.
		-- Apella, "A Private Little War", stardate 4211.8

--nextPart3050781.V5ZeAGbvfd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB0QFDgbFCivvqDfQRApc6AJ9AlI6hOKibJFt67Htn7+mRUxQybQCdGFhM
/jeDHunMXauxhNYOgU67+Cc=
=eWci
-----END PGP SIGNATURE-----

--nextPart3050781.V5ZeAGbvfd--
