Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbRCLKHr>; Mon, 12 Mar 2001 05:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129456AbRCLKHi>; Mon, 12 Mar 2001 05:07:38 -0500
Received: from gondor.apana.org.au ([203.14.152.114]:45316 "EHLO
	gondor.apana.org.au") by vger.kernel.org with ESMTP
	id <S129464AbRCLKH2>; Mon, 12 Mar 2001 05:07:28 -0500
Date: Mon, 12 Mar 2001 21:05:58 +1100
From: Herbert Xu <herbert@gondor.apana.org.au>
Message-Id: <200103121005.f2CA5wg29762@gondor.apana.org.au>
To: pavel@suse.cz (Pavel Machek)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hashing and directories
X-Newsgroups: apana.lists.os.linux.kernel
In-Reply-To: <3A9EB984.C1F7E499@transmeta.com> <Pine.GSO.4.21.0103011608360.11577-100000@weyl.math.psu.edu> <20010302100410.I15061@atrey.karlin.mff.cuni.cz>
Organization: Core
User-Agent: tin/pre-1.4-980226 (UNIX) (Linux/2.4.2-586tsc (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:

> xargs is very ugly. I want to rm 12*. Just plain "rm 12*". *Not* "find
> . -name "12*" | xargs rm, which has terrible issues with files names

Try

printf "%s\0" 12* | xargs -0 rm
-- 
Debian GNU/Linux 2.2 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
