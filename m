Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030370AbWAGIy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbWAGIy7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 03:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbWAGIy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 03:54:59 -0500
Received: from mx3.mail.ru ([194.67.23.149]:65046 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S1030370AbWAGIy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 03:54:58 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: STR works if suspended for a short time but hangs for extended period
Date: Sat, 7 Jan 2006 11:54:42 +0300
User-Agent: KMail/1.9.1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601071154.43300.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I am not sure where to start digging.

Toshiba Portege 4000, vanilla 2.6.15, Mandriva with suspend-scripts. In 
principle, both STR and hibernation work. STR works just fine for testing - 
suspend, resume after several munutes, and everything works just fine. But if 
I leave system in STR state for several hours, it reliably hangs on resume. I 
have to hard power off it that has value added annoyance that keyboard is 
disabled until I turn it off again (using mouse out of kdm :)

Unless it is a known issue, I appreciate hints where to start debugging. I am 
not deep into Linu power management issues.

TIA

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDv4HTR6LMutpd94wRAumQAJ9FBwuUDwISULzxNHf60zCB/I6r1gCgg71X
/5yJRW2xU5c84NF9INPCQe4=
=y5iU
-----END PGP SIGNATURE-----
