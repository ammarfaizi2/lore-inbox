Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266686AbSK1S3R>; Thu, 28 Nov 2002 13:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266702AbSK1S3R>; Thu, 28 Nov 2002 13:29:17 -0500
Received: from pat.uio.no ([129.240.130.16]:16861 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S266686AbSK1S3Q>;
	Thu, 28 Nov 2002 13:29:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <15846.25140.759632.709205@charged.uio.no>
Date: Thu, 28 Nov 2002 19:36:36 +0100
To: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PROBLEM] NFS trouble - file corruptions
In-Reply-To: <Pine.LNX.4.44.0211281857230.1818-100000@grignard.amagerkollegiet.dk>
References: <15846.17236.556847.267054@charged.uio.no>
	<Pine.LNX.4.44.0211281857230.1818-100000@grignard.amagerkollegiet.dk>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Rasmus Bøg Hansen <moffe@amagerkollegiet.dk> writes:

    >> Does it also occur if you play around with setting rsize and
    >> wsize = 1024?

     > I'm afraid so - I just double-checked...

Given that you are saying that even synchronous RPC (which is the
default for r/wsize = 1024) is failing, then my 2 main suspicions are

  - hardware failure: Have you tried this on several different
    server/client combinations and hardware combinations?

  - gcc miscompile: which version of gcc are you using?

Cheers,
  Trond
