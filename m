Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261879AbSJIRSN>; Wed, 9 Oct 2002 13:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261878AbSJIRSM>; Wed, 9 Oct 2002 13:18:12 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:61880
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S261879AbSJIRR7>; Wed, 9 Oct 2002 13:17:59 -0400
Message-ID: <3DA46625.7040405@redhat.com>
Date: Wed, 09 Oct 2002 10:23:49 -0700
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20020812
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: alan@cotse.com
CC: phil-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Patches from Redhat gcc 3.2
References: <YWxhbg==.35e5d37d477d0ddc01cb3484f9ef3349@1034183288.cotse.net>
X-Enigmail-Version: 0.65.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Alan Willis wrote:

> Also, are any modifications needed to glibc 2.3?

I usually say what glibc version you need in the announcement.  The
stock 2.3 was fine for 03.  The next code drop will need more changes
which aren't in an official release yet.  For the time being you should
consider the CVS head as always working.  That's what I'm using internally.


> Also, I do not wish to make my system unusable with 2.4.x kernels,.. if I
> build glibc with --enable-kernel=current, will that make glibc unusable with
> 2.4.x kernels?

You mean you are building glibc on a system running 2.5?  That certainly
makes the glibc unusable on 2.4 systems.  It's the purpose of the whole
exercise.

How we will handle this in the end is another question.  ld.so already
has some functionality which can help and that's probably what we will use.


> Is this line also correct: --enable-addons=nptl,nptl_db, where
> I've untarred the nptl dirs under in the main glibc directory.

Never mentioned nptl_db in this context.  It's included automatically if
nptl is named.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE9pGYl2ijCOnn/RHQRAtReAKC9cUWj9ctvGkU345F+trFH5y3KtACgq0K3
jV3RIHYP4s+cTPxWXQbawlU=
=39YB
-----END PGP SIGNATURE-----

