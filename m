Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264467AbTEaVtj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 17:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264469AbTEaVtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 17:49:39 -0400
Received: from smtp1.utdallas.edu ([129.110.10.12]:56244 "EHLO
	smtp1.utdallas.edu") by vger.kernel.org with ESMTP id S264467AbTEaVth
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 17:49:37 -0400
Message-ID: <3ED92679.2030208@attbi.com>
Date: Sat, 31 May 2003 17:02:33 -0500
From: Jordan Breeding <jordan.breeding@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030528
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm3
References: <20030531013716.07d90773.akpm@digeo.com>
In-Reply-To: <20030531013716.07d90773.akpm@digeo.com>
X-Enigmail-Version: 0.74.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

  I have some good new and some bad news about 2.5.70-mm3.

The good news:

  The reiserfs changes seem to be stable, I have been running this
kernel on an all reiserfs box since this morning and everything seems
completely fine with it.

The bad news:

  Somewhere in the changes brought in from Linus BK (I assume since
there were USB changes there, but none that I noticed in your changes),
all my USB keyboard LEDs stopped working.  Numlock and capslock still
seem to function correctly but the LEDs on the keyboard no longer work,
with 2.5.70-mm2 they worked on VTs and in X, with 2.5.70-mm3 they don't
work on either.

Jordan

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm3/
> 
> . More ext3 fixes.  It seems fully recovered now.
> 
> . Some cleanups and enhancements to the O_SYNC rework.
> 
> . A couple of fairly significant reiserfs enhancements.  See the changelogs
>   in the individual patches for detail
> <snipped>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+2SZ9SigNyqq/SRwRAuNRAJ41zmOyRsBSAhfZgEnvtdEEvCM3lgCgnGuZ
awd9bdIuzRipIrQBM+sAvH8=
=rDoY
-----END PGP SIGNATURE-----

