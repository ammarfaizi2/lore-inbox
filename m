Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272335AbRHXWQY>; Fri, 24 Aug 2001 18:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272336AbRHXWQP>; Fri, 24 Aug 2001 18:16:15 -0400
Received: from www.ziplip.com ([216.33.158.118]:39972 "EHLO ziplip.com")
	by vger.kernel.org with ESMTP id <S272335AbRHXWQB>;
	Fri, 24 Aug 2001 18:16:01 -0400
Message-ID: <14JMJNFND03NX1BPBJGT2EP3X1JIEENOUBMDD5BK_olympus>
Date: Fri, 24 Aug 2001 15:16:17 -0700 (PDT)
From: abraxas2 <abraxas2@ziplip.com>
Reply-To: abraxas2 <abraxas2@ziplip.com>
To: linux-kernel@vger.kernel.org
Subject: No Subject
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ZLExpiry: -1
X-ZLReceiptConfirm: N
X-ZLAuthUser: abraxas2@ziplip.com
X-ZLAuthType: WEB-MAIL
X-ZLAuthOn: Y
X-Mailer: ZipLip Sonoma v3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi everybody,

i have implemented an improved linux ntfs driver.

the following changes have been done :

- full deletion support
- full hardlink support
- support for multiple mft records
- support for chmod, rename, truncate, df, du, ...
- implemented new tools ntchmod, ntlink, ntrm, ntundel (undeletion)
  there is a NT port of the tools, too
- fixed a bunch of FIXME's and another bunch of bugs

the kernel part of the sources increased almost to the double.

one of the performed tests was a complete linux kernel build on a
ntfs volume. without any complaints by chkdsk.


this is currently for kernel 2.2.x.

work is in progress for the following items :
- support for kernel 2.4.x
- support for symlinks, device files and chown/chgrp
- full support for compressed files

if you are interested, please send me an email. please indicate if you
want only the kernel part or the complete sources.

Abraxas

<abraxas2@findhere.com>


