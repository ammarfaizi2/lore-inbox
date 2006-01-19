Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbWASGrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWASGrP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 01:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWASGrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 01:47:15 -0500
Received: from uproxy.gmail.com ([66.249.92.201]:9225 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964959AbWASGrO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 01:47:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=p3+8Xn0G2nKcNX0cBclF9z0YClkY5bkT04nxHvT/c0Y/2aUGsWlmeQKgS3J88GgzJb4K5QnzEqgxeQXo05VCvPCFNYelFVa65+8d/UG+lLhIHa37G7hLGDf8mtrQ6fzLTAPD9o3KWYKVWhPUmuKtQgQH7tm5jmfWd+t/WdEmcGU=
Message-ID: <a44ae5cd0601182247h1b173289ncbc6dc405cbb0bb4@mail.gmail.com>
Date: Wed, 18 Jan 2006 22:47:13 -0800
From: Miles Lane <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.16-rc1-git1 -- Build error "make: *** [include/linux/version.h] Error 2"
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make all install modules modules_install
/bin/sh: -c: line 0: syntax error near unexpected token `('
/bin/sh: -c: line 0: `set -e; echo '  CHK    
include/linux/version.h'; mkdir -p include/linux/;      if [ `echo -n
"2.6.16-rc1-git1 .file null .ident
GCC:(GNU)4.0.320060115(prerelease)(Ubuntu4.0.2-7ubuntu1) .section
.note.GNU-stack,,@progbits" | wc -c ` -gt 64 ]; then echo
'"2.6.16-rc1-git1 .file null .ident
GCC:(GNU)4.0.320060115(prerelease)(Ubuntu4.0.2-7ubuntu1) .section
.note.GNU-stack,,@progbits" exceeds 64 characters' >&2; exit 1; fi;
(echo \#define UTS_RELEASE \"2.6.16-rc1-git1 .file null .ident
GCC:(GNU)4.0.320060115(prerelease)(Ubuntu4.0.2-7ubuntu1) .section
.note.GNU-stack,,@progbits\"; echo \#define LINUX_VERSION_CODE `expr 2
\\* 65536 + 6 \\* 256 + 16`; echo '#define KERNEL_VERSION(a,b,c) (((a)
<< 16) + ((b) << 8) + (c))'; ) < /usr/src/linux-2.6/Makefile >
include/linux/version.h.tmp; if [ -r include/linux/version.h ] && cmp
-s include/linux/version.h include/linux/version.h.tmp; then rm -f
include/linux/version.h.tmp; else echo '  UPD    
include/linux/version.h'; mv -f include/linux/version.h.tmp
include/linux/version.h; fi'
make: *** [include/linux/version.h] Error 2
