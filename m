Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbUBBUc1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265837AbUBBU35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 15:29:57 -0500
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:28038 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265766AbUBBU3L (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 15:29:11 -0500
Message-Id: <200402022028.i12KSnSQ011554@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Joshua Kwan <joshk@triplehelix.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: 2.6 input drivers FAQ 
In-Reply-To: Your message of "Mon, 02 Feb 2004 21:18:13 +0100."
             <20040202201813.GA272@ucw.cz> 
From: Valdis.Kletnieks@vt.edu
References: <20040201100644.GA2201@ucw.cz> <20040201163136.GF11391@triplehelix.org> <200402020527.i125RvTx008088@turing-police.cc.vt.edu> <20040202092318.GD548@ucw.cz> <200402021812.i12IC6eR006637@turing-police.cc.vt.edu>
            <20040202201813.GA272@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-172395625P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Feb 2004 15:28:49 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-172395625P
Content-Type: text/plain; charset=us-ascii

On Mon, 02 Feb 2004 21:18:13 +0100, Vojtech Pavlik said:

> Because normally the X server reads them in very quick succession and if
> you don't make a very short click, the sequence looks like this:
> 
> push1 push2 release1 release2, which is fine, because X interprets that
> as just a push and a release.
> 
> If there is disk activity or something else that causes the scheduling
> to be delayed, it's push1 release1 push2 release2, which counts as a
> doubleclick.
> 
> Hence sporadic doubleclicking.

Well.. that would explain things except for the single /dev/psaux I have.

Could a similar timing hole happen if the system submerged into SMM
code for a battery check or similar? (I know, that *should* cause
lost events not duplicated, but....)

> For movement, of course, you get twice the mouse speed, but usually most
> people just adjust the acceleration settings and are done with that.

Haven't seen this.

--==_Exmh_-172395625P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAHrMBcC3lWbTT17ARAj/CAKCAL5+RxIvzxShxf8lEeBQyHF1z5ACfXbct
zrVISUbRAKL8u2gyDWmzbpo=
=BKQe
-----END PGP SIGNATURE-----

--==_Exmh_-172395625P--
