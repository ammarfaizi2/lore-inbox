Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265275AbUBFJX6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 04:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265333AbUBFJX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 04:23:58 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:1178 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP id S265275AbUBFJX5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 04:23:57 -0500
Message-ID: <40235D0B.5090008@redhat.com>
Date: Fri, 06 Feb 2004 01:23:23 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Rik van Riel <riel@redhat.com>, Jamie Lokier <jamie@shareable.org>,
       Andi Kleen <ak@suse.de>, johnstul@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
References: <20040205214348.GK31926@dualathlon.random> <Pine.LNX.4.44.0402052314360.5933-100000@chimarrao.boston.redhat.com> <20040206042815.GO31926@dualathlon.random>
In-Reply-To: <20040206042815.GO31926@dualathlon.random>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrea Arcangeli wrote:

> I don't think I was arguing against it completely, exactly because I'm
> just saying it should be optional.

And the result is that the current fast syscall handling on x86-64 is
completely unacceptable.  If it's not change security enhancements are
not possible since the libc has to hardcode the address.

- -- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAI10P2ijCOnn/RHQRAuegAKCtk8W1cXWKlTWkDrmfJfykzvqATQCfRX4Q
cUVAR4+yIue/MFRL2xNbwfQ=
=VHoF
-----END PGP SIGNATURE-----
