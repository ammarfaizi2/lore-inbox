Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262253AbRERG2q>; Fri, 18 May 2001 02:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262254AbRERG2g>; Fri, 18 May 2001 02:28:36 -0400
Received: from www.sinfopragma.it ([213.26.181.2]:6667 "EHLO
	sinfo-www-01.sinfopragma.it") by vger.kernel.org with ESMTP
	id <S262253AbRERG22>; Fri, 18 May 2001 02:28:28 -0400
Date: Fri, 18 May 2001 08:32:29 +0200 (W. Europe Daylight Time)
From: Lorenzo Marcantonio <lorenzo.marcantonio@sinfopragma.it>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: <root@chaos.analogic.com>, "H. Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.4 failure to compile
In-Reply-To: <3B041E06.BF5155ED@transmeta.com>
Message-ID: <Pine.WNT.4.31.0105180827380.65-100000@pc209.sinfopragma.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2001, H. Peter Anvin wrote:

> I think the header file you're talking about is the db1 header file,
> which has nothing to do with yacc -- it's the Berkeley libdb version 1,
> which is a pretty bad thing to require.
>

I've got it to compile (and apparently work) even con libdb3... which
has the compability header db_185.h (or something similar).

IIRC, libdb1 was bundled with libc till release 2.1.3. Since 2.2 they've
said 'get it at sleepycat...'.

BTW, there are ifdef inside the driver about which header to include
(db.h or db_185.h IIRC).

I still doesn't comprend what does it NEED FOR the libdb...

				-- Lorenzo Marcantonio


