Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270272AbTGRTUb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 15:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270283AbTGRTUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 15:20:31 -0400
Received: from [65.77.42.170] ([65.77.42.170]:11271 "EHLO vds.footech.com")
	by vger.kernel.org with ESMTP id S270272AbTGRTU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 15:20:29 -0400
Date: Fri, 18 Jul 2003 12:35:22 -0700
Message-Id: <200307181935.h6IJZMo03779@vds.footech.com>
To: linux-kernel@vger.kernel.org
From: Doug Jolley <doug@footech.com>
Subject: Bug in make menuconfig
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi --

I first noticed a bug in make menuconfig under 2.4 kernel.
Basically, while running the menuconfig target, if one
tries to load an alternative configuration file, the
cursor cannot be positioned into the area for adding the
name of the file.  It turns out that it works; but, an
unsuspecting user would likely not know that it is
working because the cursor position doesn't change.  It's
really a much more difficult problem to explain than it
is to observe.  Just try 'make menuconfig' and try to tab
so that the cursor is appropriately positioned so as to
be able to enter the name of an alternative configuration
file to load.  You'll see right away what I'm talking about.

As I say, I first noticed this under the 2.4 kernel.
I thought it would surely get fixed in the next release.
I see that the bug is still present in 2.6.0-test1.
Accordingly, I thought I should mention it.

Thanks and keep up the extroardinarily good work!

     ... doug
         (Linux+ Certified Professional)
         (LPI Level 1 Certified)
_____________________________________________________________________
Doug Jolley     mailto://doug@footech.com      http://www.footech.com
         Don't bogart that file, my friend.  Net it over to me.
#####################################################################
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: http://www.footech.com/doug/pubkey.asc

iD8DBQE/GE0PGg43bNIg8sERAks5AKDi8+npvHK1SmIW1aR2ZfPMNnm30gCeIGFE
E2keGd4kvs/1jIXwZUBcXqc=
=LdUR
-----END PGP SIGNATURE-----
