Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317215AbSIAQdv>; Sun, 1 Sep 2002 12:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317253AbSIAQdv>; Sun, 1 Sep 2002 12:33:51 -0400
Received: from pat.uio.no ([129.240.130.16]:58612 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S317215AbSIAQdu>;
	Sun, 1 Sep 2002 12:33:50 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15730.17012.61365.788871@charged.uio.no>
Date: Sun, 1 Sep 2002 18:38:12 +0200
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Initial support for struct vfs_cred   [0/1]
In-Reply-To: <1030890821.2145.67.camel@ldb>
References: <Pine.LNX.4.44.0208311235110.1255-100000@home.transmeta.com>
	<1030822731.1458.127.camel@ldb>
	<15729.17279.474307.914587@charged.uio.no>
	<1030835635.1422.39.camel@ldb>
	<15730.4100.308481.326297@charged.uio.no>
	<1030890821.2145.67.camel@ldb>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Luca Barbieri <ldb@ldb.ods.org> writes:

     > That's what the code did, unless I misunderstood it.  Anyway if
     > you want to give a different fsuid to a filesystem function,
     > you either pass credentials as a parameter (that means that you
     > change all the functions in the call chain to do that) or you

If you read through the beginning of the thread, you will see that
this is *exactly* what I'm proposing to do. Just not in this one
already very large patch.

Cheers,
  Trond
