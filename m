Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTKHTTt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 14:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTKHTTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 14:19:49 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:46819
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S262108AbTKHTTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 14:19:48 -0500
Message-ID: <3FAD418D.2080508@redhat.com>
Date: Sat, 08 Nov 2003 11:18:37 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Anton Blanchard <anton@samba.org>,
       Denis <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6-test6: nanosleep+SIGCONT weirdness
References: <Pine.LNX.4.44.0311081053350.7319-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0311081053350.7319-100000@home.osdl.org>
X-Enigmail-Version: 0.81.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:

> I can try to fix the posix-timer.c code too, but it looks like even modern
> glibc doesn't even export the clock_nanosleep() function. So it might not 
> be worth fixing at this point..

Of course it's supported.  the clock_* functions are in librt.  And they
are supported and, when working, greatly increase the usability.  The
old user-level implementation is as good as we get it but really not up
to the job.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/rUGN2ijCOnn/RHQRAtV2AKCTXNl4dAW2OXzxmmvox6uEXxBSBwCfboRq
Ml2plaRE9tY7YzB19auWmUQ=
=sZrM
-----END PGP SIGNATURE-----

