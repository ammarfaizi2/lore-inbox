Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267616AbSLFG1e>; Fri, 6 Dec 2002 01:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267617AbSLFG1e>; Fri, 6 Dec 2002 01:27:34 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:24704 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S267616AbSLFG1d> convert rfc822-to-8bit; Fri, 6 Dec 2002 01:27:33 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [BUG]2.4.19-ck7
Date: Fri, 6 Dec 2002 17:37:32 +1100
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212061737.36906.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I've gone back and looked at ck7 (was a little while ago). -ck doesnt directly 
alter skbuff.c but may be responsible for calling it in an interrupt. I'm 
sorry I can't enlighten you as to why it's happening and offer a fix as I 
don't really know what the problem is.

The fact that it's happening now regularly and not previously is unusual if 
the kernel itself is responsible unless some pattern in your usage has 
changed. Perhaps seeing if the problem repeats on a vanilla or alternate 
kernel may be helpful (-ck is rather different from vanilla).

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE98EWvF6dfvkL3i1gRAnDbAJwN5YR8X1P/YR7XQLKAg+q1orm2SQCcDf+A
i3iLphPRc5au7WsXBci+npA=
=JMES
-----END PGP SIGNATURE-----
