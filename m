Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267926AbUIGMGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267926AbUIGMGl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 08:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267951AbUIGMGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 08:06:40 -0400
Received: from pat.uio.no ([129.240.130.16]:6530 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S267926AbUIGMG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 08:06:28 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm4
References: <20040907020831.62390588.akpm@osdl.org>
From: Terje Kvernes <terjekv@math.uio.no>
Organization: The friends of mr. Tux
X-URL: http://terje.kvernes.no/
Date: Tue, 07 Sep 2004 14:05:52 +0200
In-Reply-To: <20040907020831.62390588.akpm@osdl.org> (Andrew Morton's
 message of "Tue, 7 Sep 2004 02:08:31 -0700")
Message-ID: <wxxk6v6l1wf.fsf@nommo.uio.no>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-5, required 12,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm4/
> 
> - Added Dave Howells' mysterious CacheFS.

  [ ... ]

> +make-afs-use-cachefs.patch

  without selecting cachefs, I get:

 CC [M]  fs/afs/callback.o
In file included from fs/afs/vnode.h:16,
                 from fs/afs/callback.c:20:
include/linux/cachefs.h:347:2: #error 
make[2]: *** [fs/afs/callback.o] Error 1
make[1]: *** [fs/afs] Error 2
make: *** [fs] Error 2

  after selecting cachefs, afs builds as it should.  a missing
  dependency?


-- 
Terje
