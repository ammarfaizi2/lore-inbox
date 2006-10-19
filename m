Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161020AbWJSFaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbWJSFaK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 01:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161019AbWJSFaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 01:30:10 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:53700 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1161020AbWJSFaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 01:30:08 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Neil Brown <neilb@suse.de>, Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] nfs endianness annotations
Date: Thu, 19 Oct 2006 15:30:25 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <du2ej21g7pkccoe4cigs8r9gsq1ir6nc9p@4ax.com>
References: <E1GX7zV-00047C-PO@ZenIV.linux.org.uk> <1161206763.6095.172.camel@lade.trondhjem.org> <17718.51050.186385.512984@cse.unsw.edu.au> <20061019012600.GR29920@ftp.linux.org.uk>
In-Reply-To: <20061019012600.GR29920@ftp.linux.org.uk>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006 02:26:00 +0100, Al Viro <viro@ftp.linux.org.uk> wrote:

>Folks, seriously, please run sparse after changes; it's a simple matter of
>make C=2 CF=-D__CHECK_ENDIAN__ fs/nfs*/; nothing tricky and it saves a lot
>of potential PITA...

grant@sempro:~/linux/linux-2.6.19-rc2a$ make C=2 CF=-D__CHECK_ENDIAN__ fs/nfs*/;
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CHECK   scripts/mod/empty.c
/bin/sh: sparse: command not found
make[2]: *** [scripts/mod/empty.o] Error 127
make[1]: *** [scripts/mod] Error 2
make: *** [scripts] Error 2

What sparse?  Pointer please?  Hell of a keyword to search for :(

Thanks,
Grant.
