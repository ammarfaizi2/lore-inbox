Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbTKQTTK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 14:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263666AbTKQTTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 14:19:10 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:8836 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP id S263661AbTKQTTG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 14:19:06 -0500
Message-ID: <3FB91F22.6090805@redhat.com>
Date: Mon, 17 Nov 2003 11:18:58 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] POSIX message queues - syscalls & SIGEV_THREAD
References: <Pine.GSO.4.58.0311161546260.25475@Juliusz> <20031117064832.GA16597@mail.shareable.org> <Pine.GSO.4.58.0311171236420.29330@Juliusz> <20031117153323.GA18523@mail.shareable.org>
In-Reply-To: <20031117153323.GA18523@mail.shareable.org>
X-Enigmail-Version: 0.81.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jamie Lokier wrote:
> This is the flaw I would like to fix for async futexes,

Well, this should be discussed much more before doing anything.

IMO, for 2.6 FUTEX_FD should be removed or disabled.  It doesn't work
reliably.

As for later, and which extensions to add, Ingo and I discussed this
quite a bit already.  One of the problems is that once you extend the
basic set of operations the possible way are very numerous and the
interfaces can explode in number.

My hopes are that we can come up with some nice and generally useful
additions in the not too distant future and that they can be added to
the 2.6 kernel.  IMO we cannot wait for the next stable release.

I am not sure that this list is the adequate forum for discussing the
futex extensions.  If somebody says where it should take place and
somebody actually declares willingness to work on the implementation
side, I can write down my thoughts and post it.

- -- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/uR8i2ijCOnn/RHQRAut0AKC0zV6s/KcJfvEU8PHFmvfXbu7DdQCgwVfE
BpRqDjxHzpUhhbyfmEQ97Hk=
=i2+X
-----END PGP SIGNATURE-----

