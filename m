Return-Path: <linux-kernel-owner+w=401wt.eu-S965094AbWLMTZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965094AbWLMTZU (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965092AbWLMTZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:25:20 -0500
Received: from webserve.ca ([69.90.47.180]:35043 "EHLO computersmith.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S965097AbWLMTZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:25:19 -0500
X-Greylist: delayed 1973 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 14:25:19 EST
Message-ID: <45804B99.2060008@wintersgift.com>
Date: Wed, 13 Dec 2006 10:51:05 -0800
From: Teunis Peters <teunis@wintersgift.com>
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Question: removal of syscall macros?
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Now that syscall macros have been pulled from the -mm tree, what method
is recommended to use syscalls?

(I've wasted a day grubbing through sources before giving up and copying
the old syscall macros into one key driver)

_syscall macros are used by:
ATI driver  (no choice.  I'm working with laptops)
vmware  (I'm trying to phase this out for qemu, but it's a slow process)
(and others I suspect)

I realize that these are "closed source" but my work is rather dependant
on them remaining operational - and as the 2.6.19 kernel series is the
only one that works on most of the hardware provided by my workplace,
I'm kind of stuck patching things myself.

There doesn't seem to be any documentation on this so I ask about how to
replace the _syscallX calls.

Thank you!
	- Teunis
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFgEuYbFT/SAfwLKMRAqYoAJ4xiJGcoJ6EB6kKX1VGALib1NrQyQCeNUzv
AgYtPKfC6SpwBY6PgyLbZeI=
=jN5z
-----END PGP SIGNATURE-----
