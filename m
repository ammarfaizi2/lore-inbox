Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278985AbRKAO0C>; Thu, 1 Nov 2001 09:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279006AbRKAOZw>; Thu, 1 Nov 2001 09:25:52 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:54235 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S278985AbRKAOZq>; Thu, 1 Nov 2001 09:25:46 -0500
Date: Thu, 1 Nov 2001 14:25:44 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: driver initialisation order problem
Message-ID: <20011101142544.T20398@redhat.com>
In-Reply-To: <20011101141412.R20398@redhat.com> <3BE15A85.8B9DF165@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="0OkqknLvuh6i3jtt"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BE15A85.8B9DF165@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Nov 01, 2001 at 09:21:57AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OkqknLvuh6i3jtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 01, 2001 at 09:21:57AM -0500, Jeff Garzik wrote:

> I would move lp to parport, since IMHO it belongs there anyway.

It isn't confined to just lp:

$ grep -l parport $(find drivers/char -name '*.c')
drivers/char/lp.c
drivers/char/ppdev.c
drivers/char/joystick/turbografx.c
drivers/char/joystick/db9.c
drivers/char/joystick/gamecon.c

Tim.
*/

--0OkqknLvuh6i3jtt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE74VtoyaXy9qA00+cRAlx6AJ4lgM3XpAIwb7b3Mr85s9FTmn0nOQCeJeq3
BbxXIWschbPLTwdE85CT44U=
=y17b
-----END PGP SIGNATURE-----

--0OkqknLvuh6i3jtt--
