Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277957AbRJRSnV>; Thu, 18 Oct 2001 14:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277966AbRJRSnO>; Thu, 18 Oct 2001 14:43:14 -0400
Received: from cx552039-a.elcjn1.sdca.home.com ([24.177.44.17]:49026 "EHLO
	tigger.unnerving.org") by vger.kernel.org with ESMTP
	id <S277957AbRJRSlu>; Thu, 18 Oct 2001 14:41:50 -0400
Date: Thu, 18 Oct 2001 11:42:05 -0700 (PDT)
From: Gregory Ade <gkade@bigbrother.net>
X-X-Sender: <gkade@tigger.unnerving.org>
To: <linux-kernel@vger.kernel.org>
Subject: 2.2.x process limits (NR_TASKS)?
Message-ID: <Pine.LNX.4.33.0110181139380.30308-100000@tigger.unnerving.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

We're running into what appears to be a 256-process-per-user limit on one
of our webservers, due to the number of processes running as a specific
user for our application.  I'd like to increase the process limit, and
*THINK* that to do so i need to increase NR_TASKS in
/usr/src/linux/include/linux/tasks.h.

Is this correct?  What other things do I need to watch out for when making
this modification?

Also, where can this limit be changed in 2.4.x?

Thanks ahead of time.

- -- 
Gregory K. Ade <gkade@unnerving.org>
http://unnerving.org/~gkade
OpenPGP Key ID: EAF4844B  keyserver: pgpkeys.mit.edu
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7zyKJeQUEYOr0hEsRAp6PAJ4lkIEGskwko9xrbhJuiU1kyhdLTgCgryc9
UnP+9CzAwfM9nIgluW36yLY=
=xuPV
-----END PGP SIGNATURE-----


