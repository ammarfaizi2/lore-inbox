Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135350AbRAHVxc>; Mon, 8 Jan 2001 16:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135351AbRAHVxW>; Mon, 8 Jan 2001 16:53:22 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:44791 "EHLO
	mf2.private") by vger.kernel.org with ESMTP id <S135350AbRAHVxP>;
	Mon, 8 Jan 2001 16:53:15 -0500
Date: Mon, 8 Jan 2001 13:56:08 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: Szabolcs Szakacsits <szaka@f-secure.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Subtle MM bug
In-Reply-To: <Pine.LNX.4.30.0101082207290.3435-100000@fs129-124.f-secure.com>
Message-ID: <Pine.LNX.4.30.0101081352400.954-100000@mf2.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Szabolcs Szakacsits wrote:

> AFAIK newer glibc = CVS glibc but the malloc() tune parameters work
> via environment variables for the current stable ones as well,

Hmm, this must have been introduced in libc6?  Unfortunately, I don't have
the source code to MAGMA, and the binary I have is statically linked.  It
does not contain the names of the environment variables you mentioned.

I'll arrange a binary linked against glibc2.2, and then your suggestion
will hopefully do the trick.  Thanks for your kind help!

Cheers,
Wayne



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
