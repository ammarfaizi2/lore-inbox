Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263457AbUEPKW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263457AbUEPKW0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 06:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUEPKW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 06:22:26 -0400
Received: from apate.telenet-ops.be ([195.130.132.57]:10654 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S263457AbUEPKWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 06:22:24 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.6] Synaptics driver is 'jumpy'
Date: Sun, 16 May 2004 12:22:44 +0200
User-Agent: KMail/1.6.2
Cc: Dmitry Torokhov <dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405161222.48581.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello List,

Since installing 2.6.6 on my trusty laptop, I can't use the built-in synaptics
touchpad anymore. The tracking is totally broken:

When you touch-drag on the touchpad, the mouse cursor will jump to where you
stopped your action approx. 1/1.5 seconds _after_ your move. This makes using
the touchpad virtually impossible.

This problem is not present under 2.6.5, which I'm running right now.
Same .config.

Nothing seems to show up in the logs that could reflect any problem.

Any pointers?

Jan
- --
Q:	"What is the burning question on the mind of every dyslexic
	existentialist?"
A:	"Is there a dog?"
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAp0D2UQQOfidJUwQRAj6LAJ9B+0XoTi2cgFgZ1nzwCDcBknK6jgCeJw4G
48iBfznIMUmS0nQ8duhmrE4=
=6OiP
-----END PGP SIGNATURE-----
