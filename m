Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbTKOJih (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 04:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbTKOJih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 04:38:37 -0500
Received: from komoseva.globalnet.hr ([213.149.32.250]:35593 "EHLO
	komoseva.globalnet.hr") by vger.kernel.org with ESMTP
	id S261569AbTKOJif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 04:38:35 -0500
Date: Sat, 15 Nov 2003 10:08:01 +0100
From: Vid Strpic <vms@bofhlet.net>
To: Patrick Beard <patrick@scotcomms.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 VFAT problem
Message-ID: <20031115090801.GV21265@home.bofhlet.net>
Mail-Followup-To: Vid Strpic <vms@bofhlet.net>,
	Patrick Beard <patrick@scotcomms.co.uk>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b8GWCKCLzrXbuNet"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.6.0-test9
X-Editor: VIM - Vi IMproved 6.2 (2003 Jun 1, compiled Sep 18 2003 13:09:52)
X-I-came-from: scary devil monastery
X-Politics: UNIX fundamentalist
X-Face: -|!t[0Pql@=P`A=@?]]hx(Oh!2jK='NQO#A$ir7jYOC*/4DA~eH7XpA/:vM>M@GLqAYUg9$ n|mt)QK1=LZBL3sp?mL=lFuw3V./Q&XotFmCH<Rr(ugDuDx,mM*If&mJvqtb3BF7~~Guczc0!G0C`2 _A.v7)%SGk:.dgpOc1Ra^A$1wgMrW=66X|Lyk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--b8GWCKCLzrXbuNet
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2003 at 01:46:51PM -0000, Patrick Beard wrote:
> >> FAT: Bogus number of reserved sectors
> >> VFS: Can't find a valid FAT filesystem on dev sda
> >Oh, no, not again... :(
> >We had the same problem few weeks ago... a patch is in the archives, it
> >worked for me.
> I did apply Andries's 'Relax FAT checking' patch last night but the only
> difference I noticed was my belkin reader changed it's error to 'no media
> found' the camera still gave 'wrong fs...'

Hmmm.

> After advice from Philippe and Andries and the following I found on a
> website;
> "The problem is that Linux only looks at the disk geometry the first time
> the camera is plugged in. So when you unplug the camera and change the
> memory card Linux does not check to see if the geometry has changed."

I didn't know that... it shouldn't happen?  I don't connect my camera by
usb-storage, I have a card reader, and it really behaves as removable
media device, as it should - checks size everytime.  Maybe we should
change something here?

> I really hope I've not chased my tail by hitting the following combination
> 'up-patched inode.c' + 'trying to use sda after a deja search' and finally
> 'Linux only checking the geometry once'. I'd like to put this thread on h=
old
> until I take stock of the steps I've taken just to make sure I've not bee=
n a
> right 'plum'.

Well, those things sometimes take a lot of time.

--=20
           vms@bofhlet.net, IRC:*@Martin, /bin/zsh. C|N>K
Linux moria 2.6.0-test9 #1 Sat Oct 25 23:00:37 CEST 2003 i686
 10:05:31 up 9 days, 19:22,  1 user,  load average: 0.30, 0.48, 0.29
Eagles may soar, but weasels don't get sucked into jet engines.

--b8GWCKCLzrXbuNet
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/tezxq1AzG0/iPGMRAqNjAKCaGiA5fpVKZKy/DCT13kUdNf+W2wCbBhTR
FJPt4Szlc2T4H+ucqq7k5XU=
=FHzr
-----END PGP SIGNATURE-----

--b8GWCKCLzrXbuNet--
