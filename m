Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263981AbTJ1Ocq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 09:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263985AbTJ1Ocq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 09:32:46 -0500
Received: from mail.somanetworks.com ([216.126.67.42]:59060 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id S263981AbTJ1Oco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 09:32:44 -0500
Date: Tue, 28 Oct 2003 09:32:37 -0500
From: Georg Nikodym <georgn@somanetworks.com>
To: linux-kernel@vger.kernel.org
Subject: weird mouse movement in 2.6.0-test9
Message-Id: <20031028093237.65d7c8f2.georgn@somanetworks.com>
Organization: SOMA Networks
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-pc-linux-gnu)
X-Face: #EE>^U0b8z^y>O0BZ>JJMGXyyxSP?<W-(g1&Yh;2p1'N6AeM]{Zfu(v>Uhe8ptGua4P}`QZ
 m%yb7CYwN^TiGQcP&mncyDrjAtLh7cB|m{$C,ww;yaYi*YvQllxb*vet
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__28_Oct_2003_09_32_37_-0500_AFueFRNX7Ri7IVYp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__28_Oct_2003_09_32_37_-0500_AFueFRNX7Ri7IVYp
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Lately, I've been noticing the mouse cursor ever so slightly moving
around as I type.  I was beginning to wonder about my beer intake when I
discovered that I can hold a modifier like shift or control and watch
the mouse cursor dance around the screen.  Doesn't happen all the time
but often enough that if you have a similar problem you won't have any
trouble reproducing.

It looks as though there's an entity in the input subsystem that
normally ignores spurious noise from the mouse.  This "noise
suppression" seems to be disabled when handling key presses.

Some details.  The mouse is a basic logitech wheel mouse connected via
usb to a dell i8k laptop.  To rule out the touchpad/keyboard clitorus, I
can disconnect the mouse and the problem stops.

So has anybody else seen anything like this or should I be seeking
therapy?

-g

--Signature=_Tue__28_Oct_2003_09_32_37_-0500_AFueFRNX7Ri7IVYp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/nn4IoJNnikTddkMRAnHnAKCxECltZ6wym0FnX99BpV3pQEOxGACgk08C
iHn0CtM3Ro4q+x55xThd4XY=
=BKVT
-----END PGP SIGNATURE-----

--Signature=_Tue__28_Oct_2003_09_32_37_-0500_AFueFRNX7Ri7IVYp--
