Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262715AbVDHHCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262715AbVDHHCx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 03:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbVDHHCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 03:02:53 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:49583 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S262715AbVDHHCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 03:02:32 -0400
From: Rolf Eike Beer <eike-hotplug@sf-tec.de>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] PCI Hotplug: remove code duplication in drivers/pci/hotplug/ibmphp_pci.c
Date: Fri, 8 Apr 2005 09:02:21 +0200
User-Agent: KMail/1.7.2
References: <1112399271636@kroah.com> <200504021420.16772@bilbo.math.uni-mannheim.de> <20050408000745.GA7010@kroah.com>
In-Reply-To: <20050408000745.GA7010@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1746927.Wtk02xoCJZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200504080902.31933@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1746927.Wtk02xoCJZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Greg KH wrote:
> On Sat, Apr 02, 2005 at 02:20:11PM +0200, Rolf Eike Beer wrote:
> > Greg KH wrote:
> > > ChangeSet 1.2181.16.9, 2005/03/17 13:54:33-08:00,
> > > eike-hotplug@sf-tec.de
> > >
> > > [PATCH] PCI Hotplug: remove code duplication in
> > > drivers/pci/hotplug/ibmphp_pci.c
> > >
> > > This patch removes some code duplication where if and else have the
> > > same code at the beginning and the end of the branch.
> >
> > Greg, as you correctly pointed out this patch if broken. It could never
> > reach the if branch and always uses the else branch. Please drop this o=
ne
> > and review the patch I sent on March 21th to pcihp-discuss for inclusio=
n.
> > It removes much more duplication and handles this case correctly. Sorry,
> > it looks like I forgot to CC you. I'll bounce this mail to you.
>
> Hm, care to send me a patch that backs the old one out?  Or just one
> that fixes it properly, I can't really revert the old patch, now that
> I'm not using bitkeeper :)

Yes, I'll prepare one at the weekend when I have access to my patches again=
=2E=20
Mail will be sent out on monday. I'll send you two patches: first one to fi=
x=20
it properly and then one that cleans up a bit more. The second one will do=
=20
the same things like the patch I forwarded you on April 2nd. It would be ni=
ce=20
if you could have a look on this patch in the mean time so you maybe can=20
apply the second one immediately.

Eike

--nextPart1746927.Wtk02xoCJZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD4DBQBCViyHXKSJPmm5/E4RAuPHAJdIZ2jTEv8E/xYDfAIPglnz/JudAKCAPIfz
AaOIouw/F+UkpP9Ao7r/0w==
=HO/w
-----END PGP SIGNATURE-----

--nextPart1746927.Wtk02xoCJZ--
