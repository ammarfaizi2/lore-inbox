Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265894AbSKTIeu>; Wed, 20 Nov 2002 03:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265895AbSKTIeu>; Wed, 20 Nov 2002 03:34:50 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:22158
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S265894AbSKTIeu>; Wed, 20 Nov 2002 03:34:50 -0500
Message-ID: <3DDB4AD0.40800@redhat.com>
Date: Wed, 20 Nov 2002 00:41:52 -0800
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021118
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading enhancements, tid-2.5.48-A1
References: <Pine.LNX.4.44.0211201050310.30357-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0211201050310.30357-100000@localhost.localdomain>
X-Enigmail-Version: 0.65.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ingo Molnar wrote:
> here's an update to the patch, Ulrich noticed that the x86 register
> parameters were incorrect, the correct use is %edx for the parent pointer,
> %edi for the child pointer.

This patch works just fine for the adequately adjusted nptl.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE920rQ2ijCOnn/RHQRAgb3AKCsAWcAJxixpO0iUyURrZXxD+ViCACfU5Qc
mmygn+orhoBq2ypStbgSxYI=
=YG+H
-----END PGP SIGNATURE-----

