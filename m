Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265407AbUEUIMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265407AbUEUIMT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 04:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265426AbUEUIMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 04:12:19 -0400
Received: from host79.200-117-132.telecom.net.ar ([200.117.132.79]:979 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S265407AbUEUIMP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 04:12:15 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm4: missing symbol __log_start_commit in ext3.o
Date: Fri, 21 May 2004 05:12:16 -0300
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, knobi@knobisoft.de,
       "Theodore Ts'o" <tytso@mit.edu>
References: <20040519151913.47070.qmail@web13906.mail.yahoo.com> <20040520145956.749567cb.akpm@osdl.org>
In-Reply-To: <20040520145956.749567cb.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405210512.16414.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>  25-akpm/fs/ext3/balloc.c    |   28 ++--------------------------
>  25-akpm/fs/jbd/journal.c    |   34 ++++++++++++++++++++++++++++++++++
>  25-akpm/include/linux/jbd.h |    1 +

Is it just  me or is this patch wrong? It doesn't apply to 2.6.6-mm4.

nbensa@venkman:~/linux-2.6.6-mm4$ patch -Rp1 < ../__log_start_commit.patch
patching file fs/jbd/journal.c
Hunk #1 FAILED at 73.
Hunk #2 FAILED at 465.
2 out of 2 hunks FAILED -- saving rejects to file fs/jbd/journal.c.rej
patching file fs/ext3/balloc.c
Hunk #1 FAILED at 977.
1 out of 1 hunk FAILED -- saving rejects to file fs/ext3/balloc.c.rej
patching file include/linux/jbd.h
Hunk #1 FAILED at 1006.
1 out of 1 hunk FAILED -- saving rejects to file include/linux/jbd.h.rej

