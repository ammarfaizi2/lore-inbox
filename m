Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265470AbSKKEdh>; Sun, 10 Nov 2002 23:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265515AbSKKEdh>; Sun, 10 Nov 2002 23:33:37 -0500
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.228]:44943 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S265470AbSKKEdg>; Sun, 10 Nov 2002 23:33:36 -0500
Date: Sun, 10 Nov 2002 23:32:52 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@linux-dev
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: 2.5.47 : fs/nfsd/nfs4proc.c compile error
Message-ID: <Pine.LNX.4.44.0211102331390.6444-100000@linux-dev>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   While 'make bzImage', I received the following error.

Regards,
Frank

fs/nfsd/nfs4proc.c: In function `nfsd4_write':
fs/nfsd/nfs4proc.c:484: warning: passing arg 4 of `nfsd_write' from incompatible pointer type
fs/nfsd/nfs4proc.c:484: warning: passing arg 6 of `nfsd_write' makes integer from pointer without a cast
fs/nfsd/nfs4proc.c:484: too few arguments to function `nfsd_write'
fs/nfsd/nfs4proc.c: In function `nfsd4_proc_compound':
fs/nfsd/nfs4proc.c:568: structure has no member named `rq_resbuf'
fs/nfsd/nfs4proc.c:569: structure has no member named `rq_resbuf'
fs/nfsd/nfs4proc.c:569: structure has no member named `rq_resbuf'
make[2]: *** [fs/nfsd/nfs4proc.o] Error 1
make[1]: *** [fs/nfsd] Error 2
make: *** [fs] Error 2

