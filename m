Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315623AbSECKKE>; Fri, 3 May 2002 06:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315624AbSECKKD>; Fri, 3 May 2002 06:10:03 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:8209 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S315623AbSECKKC>; Fri, 3 May 2002 06:10:02 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
Date: 3 May 2002 10:06:04 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrnad4o8c.hbt.kraxel@bytesex.org>
In-Reply-To: <7691.1020402149@kao2.melbourne.sgi.com>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1020420364 17790 127.0.0.1 (3 May 2002 10:06:04 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Do it with NO_MAKEFILE_GEN=1 for much, much! faster builds.

What exactly is the reason for this hack, i.e. why kbuild wants to
rebuild the Makefiles every time?  Isn't it enougth to do that only
if .config has been touched?

  Gerd

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
