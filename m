Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280074AbRKEAkB>; Sun, 4 Nov 2001 19:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280081AbRKEAjm>; Sun, 4 Nov 2001 19:39:42 -0500
Received: from f05s15.cac.psu.edu ([128.118.141.58]:40076 "EHLO
	f05n15.cac.psu.edu") by vger.kernel.org with ESMTP
	id <S280073AbRKEAje>; Sun, 4 Nov 2001 19:39:34 -0500
Message-Id: <200111050039.TAA100998@f05n15.cac.psu.edu>
To: alan@lxorguk.ukuu.org.uk, lonnie@outstep.com
Cc: linux-kernel@vger.kernel.org
From: Phil Sorber <aafes@psu.edu>
Subject: Re: Special Kernel Modification
X-Mailer: Pygmy (v0.5.13)
Date: Sun, 04 Nov 2001 19:39:25 EST
In-Reply-To: <E160XX1-0003ZC-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


can you point me to a site so i can learn more about that binding of mounts? i recently heard something about that in plan 9, and it sounds very interesting. union mounting they call it also, correct?

On Mon, 5 Nov 2001 00:22:27 +0000 (GMT), Alan Cox wrote:
> > I have look into using things like "chroot" to restrict the users for 
> > this very special server, but that solution is not what we need.
> 
> It sounds like it is to me
> 
> > My problem is that I need to find a way to prevent the user from 
> > navigating out of their home directories.
> 
> Then you must put al the files in their home directories. Alternatively
> with later 2.4 you can use bind mounts to remount the application file
> systems below the user.
> 
> > Is there someone who might be able to give me some information on how I 
> > could add a few lines to the VFS filesystem so that I might set some 
> > type of extended attribute to prevent users from navigating out of the 
> > locations.
> 
> It isnt down to attributes - how you can run a binary or load a shared
> library you cant see.
> 
> You might also want to see http://www.nsa.gov/selinux, but that would
> require a lot of careful policy setup
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

- --
Phil Sorber
AIM: PSUdaemon
IRC: irc.openprojects.net #psulug PSUdaemon
GnuPG: keyserver - pgp.mit.edu
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE75d+9Xm6Gwek+iaQRAgnVAKCBpdA6EzpXoT/SIffK4yuPviHENgCggVq6
+6Dn7AzjrsT+S7GavhNudSI=
=eEGW
-----END PGP SIGNATURE-----
