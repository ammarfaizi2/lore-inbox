Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbUBJLFd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 06:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265818AbUBJLFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 06:05:33 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:42661 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265817AbUBJLF3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 06:05:29 -0500
From: tabris <tabris@tabris.net>
To: linux-kernel@vger.kernel.org
Subject: console/gpm mouse breakage 2.6.3-rc1-mm1
Date: Tue, 10 Feb 2004 06:05:19 -0500
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200402100605.25115.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

	just went to 2.6.3 this morning due to frustrations with my PDC20265 causing 
lockups... hoping that 2.6 solves this problem...

	and now i'm having trouble where gpm doesn't work right... cilcks don't 
register as a click event. Yes, it works fine in X (using GPM in repeater 
mode, -R raw. the old hack I used to allow X to use both mice, as well as 
eliminating the gpm crashes every couple times I switched btwn X and console 
mode.)

instead I get characters echoed to my terminal
left click: Q
right click: W
middle click: E (plus some control character... i haven't tried a capture and 
hexdump yet)

	also, my PS/2 mouse (MS IMPS/2) no longer works. from any /dev node I've 
tried.

	I do most of my work in console mode, and having no console mouse for pastes 
and such is a pain.

	This is probably some old issue hashed and rehashed, but after reading the 
LKML pretty much all the time for the last couple years, I don't remember 
this problem being mentioned.

	as another problem, tho I believe this is also well known, sensors don't 
work, as i2c-proc doesn't exist anymore and there are no /proc/ entries for 
sensors.

- --
tabris
- -
In 1869 the waffle iron was invented for people who had wrinkled waffles.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAKLry1U5ZaPMbKQcRAhg3AJ9QWqwWEaBVXBlbdOqrEg3Kd31OhwCdFFey
pS/v2GtN2n/g5aQbjyOKN/4=
=iz7k
-----END PGP SIGNATURE-----

