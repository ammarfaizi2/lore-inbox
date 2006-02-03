Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422652AbWBCS4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422652AbWBCS4Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422639AbWBCS4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:56:25 -0500
Received: from main.gmane.org ([80.91.229.2]:22726 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1422652AbWBCS4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:56:24 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Alexander Fieroch <fieroch@web.de>
Subject: [2.6.16rc2] compile error
Date: Fri, 03 Feb 2006 19:55:47 +0100
Message-ID: <ds08vk$hk$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: osten.wh.uni-dortmund.de
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: de-de, en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I can't compile kernel 2.6.16-rc[12] and get the following error:

# make
/bin/sh: -c: line 0: syntax error near unexpected token `('
/bin/sh: -c: line 0: `set -e; echo '  CHK     include/linux/version.h';
mkdir -p include/linux/;        if [ `echo -n "2.6.16-rc2 .file null
.ident GCC:(GNU)4.0.320060128(prerelease)(Debian4.0.2-8) .section
.note.GNU-stack,,@progbits" | wc -c ` -gt 64 ]; then echo '"2.6.16-rc2
.file null .ident GCC:(GNU)4.0.320060128(prerelease)(Debian4.0.2-8)
.section .note.GNU-stack,,@progbits" exceeds 64 characters' >&2; exit 1;
fi; (echo \#define UTS_RELEASE \"2.6.16-rc2 .file null .ident
GCC:(GNU)4.0.320060128(prerelease)(Debian4.0.2-8) .section
.note.GNU-stack,,@progbits\"; echo \#define LINUX_VERSION_CODE `expr 2
\\* 65536 + 6 \\* 256 + 16`; echo '#define KERNEL_VERSION(a,b,c) (((a)
<< 16) + ((b) << 8) + (c))'; ) < /usr/src/linux-2.6.16rc2/Makefile >
include/linux/version.h.tmp; if [ -r include/linux/version.h ] && cmp -s
include/linux/version.h include/linux/version.h.tmp; then rm -f
include/linux/version.h.tmp; else echo '  UPD
include/linux/version.h'; mv -f include/linux/version.h.tmp
include/linux/version.h; fi'
make: *** [include/linux/version.h] Error 2


Kernel 2.6.15 is compiling without problems. So what have I to do?

Redards,
Alexander

