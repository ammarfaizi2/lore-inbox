Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265653AbUAHRXa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 12:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265615AbUAHRWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 12:22:48 -0500
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:55644 "EHLO
	smtp-out2.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S265592AbUAHRWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 12:22:01 -0500
Date: Thu, 8 Jan 2004 17:21:50 +0000
From: Ciaran McCreesh <ciaranm@gentoo.org>
To: Alwin Meschede <ameschede@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Numbersign key dysfunctional in 2.6.1-rc
Message-Id: <20040108172150.418251dd@snowdrop.home>
In-Reply-To: <3FFD82E2.7090105@gmx.de>
References: <3FFD82E2.7090105@gmx.de>
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__8_Jan_2004_17_21_50_+0000_.f4OOtMlpP4WLAR="
X-OriginalArrivalTime: 08 Jan 2004 17:22:17.0760 (UTC) FILETIME=[F73F2200:01C3D60B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__8_Jan_2004_17_21_50_+0000_.f4OOtMlpP4WLAR=
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 08 Jan 2004 17:18:42 +0100 Alwin Meschede <ameschede@gmx.de>
wrote:
| until kernel version 2.6.1-rc1, the numbersign/tilde key on my
| Logitech USB keyboard used to generate the scancode 0x2b. Under
| 2.6.1-rc1 and newer versions, it generates 0x54, which I suppose to
| collide with SysRQ or something like that (I found some information
| indicating this in
| http://www.ussg.iu.edu/hypermail/linux/kernel/0003.2/0721.html ). As
| result, the numbersign key causes things like switching from one
| console to another instead of printing a numbersign...

My Microsoft Natural (USB, GB layout) keyboard is similarly broken. The
onboard keyboard (IBM ThinkPad T30, GB layout) is quite happy with #~,
but with the USB keyboard I get no output.

xev tells me:

KeyPress event, serial 23, synthetic NO, window 0x1a00001,
    root 0x48, subw 0x0, time 67813064, (211,112), root:(460,399),
    state 0x0, keycode 111 (keysym 0xff61, Print), same_screen YES,
    XLookupString gives 0 bytes: 
    XmbLookupString gives 0 bytes: 
    XFilterEvent returns: False

Everything works as expected with 2.6.0.

-- 
Ciaran McCreesh
Mail:    ciaranm at gentoo.org
Web:     http://dev.gentoo.org/~ciaranm


--Signature=_Thu__8_Jan_2004_17_21_50_+0000_.f4OOtMlpP4WLAR=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE//ZGx96zL6DUtXhERAo4RAKCg3wOYRy05hhBxmjk4qKfx9ufGIwCfTMsJ
zYa+de/xMB9i2zM+7ieLopM=
=5biW
-----END PGP SIGNATURE-----

--Signature=_Thu__8_Jan_2004_17_21_50_+0000_.f4OOtMlpP4WLAR=--
