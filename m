Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbUJXQKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbUJXQKB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 12:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbUJXQG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 12:06:28 -0400
Received: from imf21aec.mail.bellsouth.net ([205.152.59.69]:47335 "EHLO
	imf21aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261556AbUJXQEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 12:04:15 -0400
Date: Sun, 24 Oct 2004 11:04:10 -0500
From: Tommy Reynolds <Tommy.Reynolds@MegaCoder.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Gigantic memory leak in linux-2.6.[789]!
Message-Id: <20041024110410.0cf3f80e.Tommy.Reynolds@MegaCoder.com>
In-Reply-To: <clgc6m$u72$1@gatekeeper.tmr.com>
References: <200410221613.35913.ks@cs.aau.dk>
	<200410221613.35913.ks@cs.aau.dk>
	<Pine.LNX.4.60.0410221743590.20604@dlang.diginsite.com>
	<clgc6m$u72$1@gatekeeper.tmr.com>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i686-redhat-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$
 t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl
 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sun__24_Oct_2004_11_04_10_-0500_qpE+xpNT6wadiDb9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__24_Oct_2004_11_04_10_-0500_qpE+xpNT6wadiDb9
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Uttered Bill Davidsen <davidsen@tmr.com>, spake thus:

> With all the work Nick, Ingo,Con and others are putting into latency and 
> responsiveness, I don't understand why anyone thinks this is desirable 
> behavior. The idle loop is the perfect place to perform things like 
> this, to convert non-productive cycles into performing tasks which will 
> directly improve response and performance when the task MUST be done. 

Bill, with respect,

The idle loop is, by definition, the place to go when there is
nothing else to do.  Scrubbing memory is, by definition, not
"nothing", so leave the idle loop alone.

That's why God, or maybe it was Linus, invented kernel threads.

Cheers!

--Signature=_Sun__24_Oct_2004_11_04_10_-0500_qpE+xpNT6wadiDb9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBe9J6/0ydqkQDlQERAjEMAKCgoGR7eJN20moL0YPZ2k2Bnx+pVgCgjzOq
Ufe+dNQ/Lfr3lu64k5MDv/o=
=3zHI
-----END PGP SIGNATURE-----

--Signature=_Sun__24_Oct_2004_11_04_10_-0500_qpE+xpNT6wadiDb9--
