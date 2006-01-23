Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWAWTkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWAWTkR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 14:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWAWTkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 14:40:17 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:62629 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932460AbWAWTkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 14:40:14 -0500
Message-Id: <200601231940.k0NJe8Zo020787@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Al Boldi <a1426z@gawab.com>, Robin Holt <holt@sgi.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream... 
In-Reply-To: Your message of "Mon, 23 Jan 2006 14:26:06 EST."
             <20060123192606.GH1008@kvack.org> 
From: Valdis.Kletnieks@vt.edu
References: <200601212108.41269.a1426z@gawab.com> <20060122123335.GB26683@lnx-holt.americas.sgi.com> <200601232103.07007.a1426z@gawab.com> <200601231840.k0NIelbp017964@turing-police.cc.vt.edu>
            <20060123192606.GH1008@kvack.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1138045208_2962P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 23 Jan 2006 14:40:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1138045208_2962P
Content-Type: text/plain; charset=us-ascii

On Mon, 23 Jan 2006 14:26:06 EST, Benjamin LaHaise said:
> Actually, that is something that the vm could optimize out of the picture 
> entirely -- it is a question of whether it is worth the added complexity 
> to handle such a case.  copy_to_user already takes a slow path when it hits 
> the page fault (we do a lookup on the exception handler already) and could 
> test if an entire page is being overwritten, and if so proceed to destroy 
> the old mapping and use a fresh page from ram.

That was my point - it's easy till you start trying to get actual performance
out of it by optimizing stuff like that. ;)

--==_Exmh_1138045208_2962P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFD1TEYcC3lWbTT17ARApVEAJ993+ZWK5X5r9TQy3jjiSlhksf99ACg9Kwa
J5/K8dzfy1nBQArW/h0HXdI=
=OilI
-----END PGP SIGNATURE-----

--==_Exmh_1138045208_2962P--
