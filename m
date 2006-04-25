Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWDYAcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWDYAcX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 20:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWDYAcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 20:32:22 -0400
Received: from h80ad24de.async.vt.edu ([128.173.36.222]:57004 "EHLO
	h80ad24de.async.vt.edu") by vger.kernel.org with ESMTP
	id S932131AbWDYAcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 20:32:22 -0400
Message-Id: <200604250031.k3P0VOCL008061@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Arjan van de Ven <arjan@infradead.org>
Cc: Lars Marowsky-Bree <lmb@suse.de>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks) 
In-Reply-To: Your message of "Mon, 24 Apr 2006 11:12:22 +0200."
             <1145869942.3116.13.camel@laptopd505.fenrus.org> 
From: Valdis.Kletnieks@vt.edu
References: <20060417195146.GA8875@kroah.com> <1145309184.14497.1.camel@localhost.localdomain> <200604180229.k3I2TXXA017777@turing-police.cc.vt.edu> <4445484F.1050006@novell.com> <20060420211308.GB2360@ucw.cz> <444AF977.5050201@novell.com> <200604230933.k3N9XTZ8019756@turing-police.cc.vt.edu> <20060423145846.GA7495@thorium.jmh.mhn.de> <20060424082831.GI440@marowsky-bree.de> <1145867837.3116.7.camel@laptopd505.fenrus.org> <20060424085456.GL440@marowsky-bree.de>
            <1145869942.3116.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1145925082_2476P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Apr 2006 20:31:22 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1145925082_2476P
Content-Type: text/plain; charset=us-ascii

On Mon, 24 Apr 2006 11:12:22 +0200, Arjan van de Ven said:

> So at minimum a debate about most the hooks is in order, as well as the
> mechanism; I'm increasingly getting convinced the 'security_ops' thing
> is misdesigned. I rather have a setup where the hooks at compiletime
> resolve to the function of the LSM you've chosen (be it SELinux or
> AppArmor) rather than the current solution. It's not like you
> realistically can or want to provide both SELinux and AppArmor with the
> same kernel anyway.. 

Doing so would require some redesign work for the current code that uses
the pointers to stack SELinux and capabilities.  Not a show-stopper by
any means, just an entry for the 'to-do' list if we go that route...


--==_Exmh_1145925082_2476P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFETW3acC3lWbTT17ARAsBnAJ0SAE0E2mwtWzbcfHng+tEKvOD69wCfdYmS
a9OBrbmcQtaKbp8JOVfUHkQ=
=Zpdx
-----END PGP SIGNATURE-----

--==_Exmh_1145925082_2476P--
