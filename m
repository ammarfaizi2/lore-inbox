Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130846AbRACBt6>; Tue, 2 Jan 2001 20:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131391AbRACBts>; Tue, 2 Jan 2001 20:49:48 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:4100 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S130846AbRACBta>; Tue, 2 Jan 2001 20:49:30 -0500
Date: Wed, 3 Jan 2001 01:17:39 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Keith Owens <kaos@ocs.com.au>
cc: Paul Gortmaker <p_gortmaker@yahoo.com>,
        linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: start___kallsyms missing from i386 vmlinux.lds ? 
In-Reply-To: <27530.978431433@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.30.0101030116440.1221-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2001, Keith Owens wrote:

> Some sparc users have a slightly older version of gcc, built shortly
> before 'weak' support was added, which required those symbols to be
> defined.  Dave Miller thought the compiler problem was widespread
> enough to justify changing the source to suit the compiler instead of
> forcing sparc users to upgrade.  I suspect that super-h has the same
> problem of old compilers, I noticed that somebody added the symbols to
> sh/vmlinux.lds.

I played with weak symbols recently. Couldn't get them to work on SH or
MIPS, and gave up.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
