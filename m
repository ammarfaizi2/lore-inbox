Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVABKPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVABKPt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 05:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVABKPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 05:15:49 -0500
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:62058 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261246AbVABKPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 05:15:40 -0500
From: tabris <tabris@tabris.net>
To: Vladimir Saveliev <vs@namesys.com>
Subject: Re: kernel BUG at fs/inode.c:1116 with 2.6.10-rc{2-mm4,3-mm1}[repost]
Date: Sun, 2 Jan 2005 05:15:33 -0500
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <200412231923.14444.tabris@tabris.net> <1103903639.23776.50.camel@tribesman.namesys.com> <200412280146.27438.tabris@tabris.net>
In-Reply-To: <200412280146.27438.tabris@tabris.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1221003.EPnimoKsXo";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200501020515.35586.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1221003.EPnimoKsXo
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 28 December 2004 1:46 am, tabris wrote:
> On Friday 24 December 2004 10:54 am, Vladimir Saveliev wrote:
> > Hello
> >
> > On Fri, 2004-12-24 at 18:31, tabris wrote:
> > > On Friday 24 December 2004 3:09 am, Andrew Morton wrote:
> > > > tabris <tabris@tabris.net> wrote:
> > > > > 	Attached are the BUG reports for 2.6.10-rc2-mm4 (multiple
> > > > > BUG reports) and one from 2.6.10-rc3-mm1, plus dmesg from
> > > > > 2.6.10-rc3-mm1.
> > > >
> > > > Are you using quotas?
> > >
> > > 	Yes, I am using quotas.
> > >
> > > > What filesystem types are in use?
> > >
> > > 	I'm using reiserFS and XFS mostly, with one ext2 partition
> > > (/boot, mounted -o sync)
> >
> > Would you please try to reproduce this problem with:
> > http://marc.theaimsgroup.com/?l=reiserfs&m=110381606727976&q=p3
>
> 	Using the patch mentioned above, 14 hours uptime and no BUG yet.
> more stress testing needed however before I can declare all is well.
5 days uptime, appears to be fixed. Thanks for the patch.
>
--
tabris

--nextPart1221003.EPnimoKsXo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB18nGgbFCivvqDfQRAjXRAJ9p5OCRjZs64Moc1nDvxGOlCHJsrgCg0xC1
CE+EgJ9purQYWPCVPcaepqY=
=QsS4
-----END PGP SIGNATURE-----

--nextPart1221003.EPnimoKsXo--
