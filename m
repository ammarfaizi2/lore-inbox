Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263934AbTKSJjU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 04:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263936AbTKSJjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 04:39:20 -0500
Received: from komoseva.globalnet.hr ([213.149.32.250]:23558 "EHLO
	komoseva.globalnet.hr") by vger.kernel.org with ESMTP
	id S263934AbTKSJjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 04:39:13 -0500
Date: Wed, 19 Nov 2003 09:29:03 +0100
From: Vid Strpic <vms@bofhlet.net>
To: Nick Craig-Wood <ncw1@axis.demon.co.uk>
Cc: Patrick Beard <patrick@scotcomms.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Smartmedia 2.6.0-test9 problem.
Message-ID: <20031119082903.GC24881@home.bofhlet.net>
Mail-Followup-To: Vid Strpic <vms@bofhlet.net>,
	Nick Craig-Wood <ncw1@axis.demon.co.uk>,
	Patrick Beard <patrick@scotcomms.co.uk>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.6.0-test9
X-Editor: VIM - Vi IMproved 6.2 (2003 Jun 1, compiled Sep 18 2003 13:09:52)
X-I-came-from: scary devil monastery
X-Politics: UNIX fundamentalist
X-Face: -|!t[0Pql@=P`A=@?]]hx(Oh!2jK='NQO#A$ir7jYOC*/4DA~eH7XpA/:vM>M@GLqAYUg9$ n|mt)QK1=LZBL3sp?mL=lFuw3V./Q&XotFmCH<Rr(ugDuDx,mM*If&mJvqtb3BF7~~Guczc0!G0C`2 _A.v7)%SGk:.dgpOc1Ra^A$1wgMrW=66X|Lyk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2003 at 05:48:28PM +0000, Nick Craig-Wood wrote:
> On Tue, Nov 18, 2003 at 11:11:26AM -0000, Patrick Beard wrote:
> > I have two smartmedia cards 16mb and 64mb. I have recently compiled
> > the Debian source for Kernel 2.6.0-test9.  I normally only use my
> > 64mb card together with a usb reader. The problem I have led me to
> > the wrong conclusion which I reported to this group. For this I
> > apologise.
> I wonder if you are seeing the same thing I see...
> I have several different sized memory cards which I use using a usb
> adaptor.  The kernel (I've only tried 2.4 not 2.6) recognises the
> first one fine, but refuses to update its internal knowledge of the
> size of the card so if I insert a different sized one it doesn't mount
> properly.

I don't have that problem, luckily, but a different one...

> The work-around I use is to "rmmod usb-storage ; modprobe usb-storage"
> whenever I change memory card - this kicks the kernel into re-reading
> the size of the media (or maybe the partition table) and it all works
> fine after that.
> This obviously isn't ideal but I haven't found a better solution.

Sometimes kernel doesn't want to recognize the SM card in reader, and I
have to reinsert it, sometimes several times.  In 2.4, one `eject
/dev/sda` fixes the problem, in 2.6 not any more.  But reinserting
always helps... obviously, not ideal too, but it works for me.

--=20
           vms@bofhlet.net, IRC:*@Martin, /bin/zsh. C|N>K
Linux moria 2.6.0-test9 #1 Sat Oct 25 23:00:37 CEST 2003 i686
 09:26:41 up 13 days, 18:43,  1 user,  load average: 0.25, 0.30, 0.27

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/uynPq1AzG0/iPGMRAsU9AJ4oRv/7FjI8/54RIBSb/NSnagapvACgoYEl
v2DUiKd6CfOrrTIAyRVvrIk=
=o9km
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
