Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129769AbRBMKRm>; Tue, 13 Feb 2001 05:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129414AbRBMKRc>; Tue, 13 Feb 2001 05:17:32 -0500
Received: from fisica.ufpr.br ([200.17.209.129]:25340 "EHLO
	hoggar.fisica.ufpr.br") by vger.kernel.org with ESMTP
	id <S129550AbRBMKRR>; Tue, 13 Feb 2001 05:17:17 -0500
From: Carlos Carvalho <carlos@fisica.ufpr.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14985.2457.869083.246477@hoggar.fisica.ufpr.br>
Date: Tue, 13 Feb 2001 08:16:57 -0200
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.19pre10 doesn't compile on alphas (sunrpc)
In-Reply-To: <shslmra9a9f.fsf@charged.uio.no>
In-Reply-To: <E14SQqi-0008Bm-00@the-village.bc.nu>
	<shslmra9a9f.fsf@charged.uio.no>
X-Mailer: VM 6.90 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust (trond.myklebust@fys.uio.no) wrote on 13 February 2001 10:56:
 >Actually, since BUG() only seems to be defined on i386 platforms for
 >2.2.x, perhaps the easiest thing to do (unless somebody wants to
 >volunteer to backport all the `safe' definitions from 2.4.x) would be
 >to add the generic `*(int *)0 = 0' definition for local use by ping()
 >itself.

Yes, this is what I wanted, something just enough to catch the bug and
run 2.2.19 until we can use 2.4. Thanks.
