Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261298AbTCGAEE>; Thu, 6 Mar 2003 19:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261299AbTCGAEE>; Thu, 6 Mar 2003 19:04:04 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:1764 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S261298AbTCGAEC>; Thu, 6 Mar 2003 19:04:02 -0500
Message-ID: <3E67E4A1.1040900@redhat.com>
Date: Thu, 06 Mar 2003 16:15:29 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030305
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: george@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: POSIX timer syscalls
References: <200303062306.h26N6hrd008442@napali.hpl.hp.com>
In-Reply-To: <200303062306.h26N6hrd008442@napali.hpl.hp.com>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David Mosberger wrote:

> On a related note: as far as I can see, timer_t is declared as "int"
> on all platforms (both by kernel and glibc).  Yet if my reading of the
> kernel code is right, it's supposed to be "long" (and allegedly some
> standard claims that timer_t should be the "widest" integer on a
> platform).

There is no such claim, don't spread misinformation.

timer_t is just an ID.  No specifics of the type are defined in the
standard.  'int' is as fine as 'long' if it is OK for the implementation.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Z+Sh2ijCOnn/RHQRApRKAKCPikdEfOcciOJpineUOYjFQ78IPwCgte4x
2CxYAdahZoQ4TjEr6imBZ3U=
=UsgY
-----END PGP SIGNATURE-----

