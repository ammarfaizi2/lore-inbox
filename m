Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267678AbTGLFXX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 01:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267685AbTGLFXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 01:23:23 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:14276
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S267678AbTGLFXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 01:23:22 -0400
Message-ID: <3F0F9E9A.9050502@redhat.com>
Date: Fri, 11 Jul 2003 22:37:30 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030710 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@digeo.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: utimes/futimes/lutimes syscalls
References: <3F0F9B0C.10604@redhat.com>
In-Reply-To: <3F0F9B0C.10604@redhat.com>
X-Enigmail-Version: 0.80.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ulrich Drepper wrote:
> With the introduction of the nanosecond fields in struct stat the
> utime() syscall is kind of obsolete.  It's not possible anymore to
> restore the exact access/modification time of a file.

Replying to myself: utimes() is already available, on some
architectures.  The question is why not for archs != alpha, ia64, PA, SPARC?

And of course the question of futimes/lutimes remains.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/D56a2ijCOnn/RHQRAv9iAJ4iMFqoMSag+z09me48eEImg0I6pgCfacBt
WQMXcYFT2+9SGv9zbU3UZX0=
=dpAI
-----END PGP SIGNATURE-----

