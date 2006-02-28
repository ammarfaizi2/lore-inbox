Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932548AbWB1UMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbWB1UMA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 15:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbWB1UMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 15:12:00 -0500
Received: from bno-84-242-95-19.nat.karneval.cz ([84.242.95.19]:8935 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932548AbWB1UL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 15:11:57 -0500
Message-ID: <4404AEB7.1040103@liberouter.org>
Date: Tue, 28 Feb 2006 21:12:39 +0100
From: Jiri Slaby <slaby@liberouter.org>
User-Agent: Thunderbird 1.5 (X11/20060210)
MIME-Version: 1.0
To: Keith Parkins <kparkins@cs.rochester.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: newbie -- looking for 2.4->2.6 PCI example
References: <Pine.LNX.4.44.0602281343520.30773-100000@svankmajer.cs.rochester.edu>
In-Reply-To: <Pine.LNX.4.44.0602281343520.30773-100000@svankmajer.cs.rochester.edu>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Keith Parkins napsal(a):
> Hey,
> 
> I am about to port a small PCI module (~500 lines) from a 2.4 to a 2.6
> kernel. I browsed Jonathon Corbet's articles on lwn.net but didn't notice
> any discussion on the pci differences. Could somebody point me to a small
> straightforward driver in the 2.4 tree that has an equally straightforward
> source in the 2.6 tree?  The existing driver has poll, ioctl, open,
> release, probe, and remove callbacks and that's it. It also uses a mutex
> and spin_lock for polling and ioctl when calling
> copy_from_user/copy_to_user.
only guessing...
scull from ldd2 and ldd3?

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEBK63MsxVwznUen4RAgKPAJ4ziiJjJ1q9yVDnsy4wh8zGnmDugQCfbS33
DwYjUIn75X9U4Q5lIyH+aEo=
=jXdK
-----END PGP SIGNATURE-----
