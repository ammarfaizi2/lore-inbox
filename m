Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262291AbVGFOVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbVGFOVp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 10:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbVGFOVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 10:21:45 -0400
Received: from mxout2.iskon.hr ([213.191.128.16]:43483 "HELO mxout2.iskon.hr")
	by vger.kernel.org with SMTP id S262291AbVGFKNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 06:13:06 -0400
X-Remote-IP: 213.191.142.123
X-Remote-IP: 213.202.85.31
Date: Wed, 6 Jul 2005 12:12:57 +0200
From: Vid Strpic <vms@bofhlet.net>
To: Stefano Rivoir <s.rivoir@gts.it>
Cc: "Roberts-Thomson, James" <James.Roberts-Thomson@NBNZ.CO.NZ>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "linux-usb-devel@lists.sourceforge.net" 
	<linux-usb-devel@lists.sourceforge.net>
Subject: Re: Kernel unable to read partition table on USB Memory Key
Message-ID: <20050706101257.GH25884@home.bofhlet.net>
Mail-Followup-To: Vid Strpic <vms@bofhlet.net>,
	Stefano Rivoir <s.rivoir@gts.it>,
	"Roberts-Thomson, James" <James.Roberts-Thomson@NBNZ.CO.NZ>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb-devel@lists.sourceforge.net" <linux-usb-devel@lists.sourceforge.net>
References: <40BC5D4C2DD333449FBDE8AE961E0C334F9364@psexc03.nbnz.co.nz> <42CA51E3.8030803@gts.it>
In-Reply-To: <42CA51E3.8030803@gts.it>
X-Operating-System: Linux 2.6.11
X-Editor: VIM - Vi IMproved 6.3 (2004 June 7, compiled Jun 26 2004 15:03:59)
X-I-came-from: scary devil monastery
X-Politics: UNIX fundamentalist
X-Face: -|!t[0Pql@=P`A=@?]]hx(Oh!2jK='NQO#A$ir7jYOC*/4DA~eH7XpA/:vM>M@GLqAYUg9$ n|mt)QK1=LZBL3sp?mL=lFuw3V./Q&XotFmCH<Rr(ugDuDx,mM*If&mJvqtb3BF7~~Guczc0!G0C`2 _A.v7)%SGk:.dgpOc1Ra^A$1wgMrW=66X|Lyk
User-Agent: Mutt/1.5.9i
X-Sanitizer: This message has been sanitized!
X-Sanitizer-URL: http://mailtools.anomy.net/
X-Sanitizer-Rev: $Id: Sanitizer.pm,v 1.87 2004/05/07 17:42:12 bre Exp $
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MIMEStream=_0+283920_68302748117508_859229203"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MIMEStream=_0+283920_68302748117508_859229203
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GpGaEY17fSl8rd50"
Content-Disposition: inline


--GpGaEY17fSl8rd50
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 05, 2005 at 11:24:51AM +0200, Stefano Rivoir wrote:
> Roberts-Thomson, James wrote:
> >I'm trying to diagnose an issue with a USB "Memory Key" (128Mb Flash dri=
ve)
> >on my workstation (i386 Linux 2.6.12 kernel, using udev 058).
> >When connecting the key, the kernel fails to read the partition table, a=
nd
> >therefore the block device /dev/sda1 isn't created, so I can't mount the
> >volume.  Calling "fdisk" manually, however, makes it all work.
> >Bus 001 Device 004: ID 0ea0:2168 Ours Technology, Inc. Transcend JetFlash
> >2.0
> Just a "vote" for this: same USB key, same symptoms, same inability to=20
> use the key: I can create the fs and use it, but once unmounted it won't=
=20
> be mounted anymore.

I have the same memory key (128Mb also), I didn't try it on recent 2.6,
but on previous ones (like, 2.6.8 for example), I know it DID work...
without problems... with factory partitioning though, I didn't
repartition...

--=20
           vms@bofhlet.net, IRC:*@Martin, /bin/zsh. C|N>K
Linux moria 2.6.11 #1 Wed Mar 9 19:08:59 CET 2005 i686
 12:10:51 up 18 days, 17:21,  1 user,  load average: 0.04, 0.49, 0.68

--GpGaEY17fSl8rd50
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFCy66pq1AzG0/iPGMRAhlGAKDI7gNQsTFqIkFrN+B6mZJU7ycPzwCfRZBw
/eQ3Nvsek2FjMGdr0rAeIKQ=
=cdfb
-----END PGP SIGNATURE-----

--GpGaEY17fSl8rd50--
--MIMEStream=_0+283920_68302748117508_859229203
Content-Type: text/sanitizer-log; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="sanitizer.log"

This message has been 'sanitized'.  This means that potentially
dangerous content has been rewritten or removed.  The following
log describes which actions were taken.

Sanitizer (start="1120644779"):
  Forcing message to be multipart/mixed, to facilitate logging.


Anomy 0.0.0 : Sanitizer.pm
$Id: Sanitizer.pm,v 1.87 2004/05/07 17:42:12 bre Exp $

--MIMEStream=_0+283920_68302748117508_859229203--
