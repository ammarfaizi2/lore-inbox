Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265292AbUFOFlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265292AbUFOFlb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 01:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265293AbUFOFlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 01:41:31 -0400
Received: from mxout2.iskon.hr ([213.191.128.16]:29649 "HELO mxout2.iskon.hr")
	by vger.kernel.org with SMTP id S265292AbUFOFl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 01:41:29 -0400
X-Remote-IP: 213.191.128.12
X-Remote-IP: 213.191.130.165
Date: Tue, 15 Jun 2004 07:38:36 +0200
From: Vid Strpic <vms@bofhlet.net>
To: Adolfo =?iso-8859-2?Q?Gonz=E1lez_Bl=E1zquez?= 
	<agblazquez_mailing@telefonica.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: pdc202xx_old serious bug with DMA on 2.6.x series
Message-ID: <20040615053836.GC2363@home.bofhlet.net>
Mail-Followup-To: Vid Strpic <vms@bofhlet.net>,
	Adolfo =?iso-8859-2?Q?Gonz=E1lez_Bl=E1zquez?= <agblazquez_mailing@telefonica.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
X-Operating-System: Linux 2.6.6
X-Editor: VIM - Vi IMproved 6.3 (2004 June 7, compiled Jun  9 2004 20:43:19)
X-I-came-from: scary devil monastery
X-Politics: UNIX fundamentalist
X-Face: -|!t[0Pql@=P`A=@?]]hx(Oh!2jK='NQO#A$ir7jYOC*/4DA~eH7XpA/:vM>M@GLqAYUg9$ n|mt)QK1=LZBL3sp?mL=lFuw3V./Q&XotFmCH<Rr(ugDuDx,mM*If&mJvqtb3BF7~~Guczc0!G0C`2 _A.v7)%SGk:.dgpOc1Ra^A$1wgMrW=66X|Lyk
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 15, 2004 at 01:20:03AM +0200, Adolfo Gonz=E1lez Bl=E1zquez wrot=
e:
> El mar, 15-06-2004 a las 01:18, Bartlomiej Zolnierkiewicz escribi=F3:
> > On Tuesday 15 of June 2004 00:50, Adolfo Gonz=E1lez Bl=E1zquez wrote:
> > > Lot of users are reporting seriour problems with pdc202xx_old ide pci
> > > driver. Enabling DMA on any device related with this driver makes the
> > > system unusable.
> > > This seems to happen in all the 2.6.x kernel series.
> > Doing binary search on 2.4->2.6 kernels would help greatly
> > (narrowing problem to a specific kernel versions).
> If it helps, I tried 2.6.2, 2.6.4, 2.6.5, and 2.6.7-rc3, and all have
> the bug.

I have the similar problem, but it only shows when doing really big file
transfers (several tens of gigabytes), not in normal usage.. DMA is
activated.

Linux moria 2.6.6 #1 Sun Jun 13 11:33:06 CEST 2004 i686 unknown unknown GNU=
/Linux

00:0f.0 RAID bus controller: Promise Technology, Inc. 20265 (rev 02)


This is onboard controller on a MSI mobo.. IRQ sharing is active.

11: 2150005 XT-PIC  ide2, ide3, ehci_hcd, uhci_hcd, CMI8738-MC6, eth0

--=20
           vms@bofhlet.net, IRC:*@Martin, /bin/zsh. C|N>K
Linux moria 2.6.6 #1 Sun Jun 13 11:33:06 CEST 2004 i686
 07:35:20 up 1 day, 19:53,  1 user,  load average: 0.35, 0.59, 0.63

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAzotcq1AzG0/iPGMRArDiAJ95pJGUqXwudxYnEThmzsNTY+zlOwCdF3q3
Ipgj35teFOMfLwj7WFh2Gko=
=GhbW
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
