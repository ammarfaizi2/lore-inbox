Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBTQ3A>; Tue, 20 Feb 2001 11:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129115AbRBTQ2u>; Tue, 20 Feb 2001 11:28:50 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:34571 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S129027AbRBTQ2j>; Tue, 20 Feb 2001 11:28:39 -0500
Date: Tue, 20 Feb 2001 17:27:45 +0100
From: Kurt Garloff <garloff@suse.de>
To: Thomas Lau <lkthomas@hkicable.com>
Cc: Chmouel Boudjnah <chmouel@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: finding Tekram SCSI dc395U linux patch driver:
Message-ID: <20010220172745.V1687@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Thomas Lau <lkthomas@hkicable.com>,
	Chmouel Boudjnah <chmouel@mandrakesoft.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.010215224622.Juergen.Schoew@unix-ag.org> <m3d7cj0zok.fsf@giants.mandrakesoft.com> <3A8D0088.2E147087@hkicable.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="VZEZlOQeSr/zV9d3"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A8D0088.2E147087@hkicable.com>; from lkthomas@hkicable.com on Fri, Feb 16, 2001 at 06:27:20PM +0800
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VZEZlOQeSr/zV9d3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 16, 2001 at 06:27:20PM +0800, Thomas Lau wrote:
> Chmouel Boudjnah wrote:
> > Juergen Schoew <Juergen.Schoew@unix-ag.uni-siegen.de> writes:
> > > On 15-Feb-01 Thomas Lau wrote:
> > > > hey, I found this driver on mandrake kernel sources, it's ac3, but I
> > > > need ac14 code, also, why still not port this driver into kernel?
> > > > the patch file already released 1 years ago
> > >
> > > Have you checked http://www.garloff.de/kurt/linux/dc395/index.html
> > > there ist a driver Version 1.32 (2000-12-02).
> >
> > it's the version included with the mandrake kernel.
> 
> Well, I think it should add to normal kernel and do not need to patch, Thanks

No, it shouldn't.
Drivers normally get added to the mainstream kernel if the driver is stable
enough and somebody acting as maintainer requests to have it included. And,
then of course, Linus / Alan / ... need to accept it.

I'm maintaining this driver, but in spite of lots of requests to add it to
the mainstream kernels, I refused to do so. The reason is that some people
(ca. 5%) using this driver are having serious problems, which I have not
been able to track down so far. In the worst case, you can end up with data
corruption. (I could reproduce and fix some of the problems, but not the data
corruption one.) As that's not funny, I do not want the driver to be in the
mainstream kernel.

> also, why this driver still stick in ac3?

?

> and where can I find the new version of this patch?

My version is on
http://www.garloff.de/kurt/linux/dc395/

> I think mandrake was improved that driver, Thanks

I would be both amazed and pissed off if this would be the case.
Amazed because somebody was investing time to work on the driver and
potentially even fix problems. 
Pissed off, because I think it's very bad to fix problems and not submit 
the patches back to the official maintainers.

BTW, if somebody can provide a reasonable description of the chip
(TRM-S1040), the chances that I'd find the bug would increase a lot ...

Regards,
-- 
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--VZEZlOQeSr/zV9d3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6kpsAxmLh6hyYd04RAhgmAJ4rH+IK6Zr3w7GZAKrcM94mpjL31wCgrnQ4
oxmfNVu9tHhKVYyhW5pa1EE=
=gu9Z
-----END PGP SIGNATURE-----

--VZEZlOQeSr/zV9d3--
