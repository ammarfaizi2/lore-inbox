Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVDZE6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVDZE6m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 00:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVDZE6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 00:58:42 -0400
Received: from 216-237-124-58.infortech.net ([216.237.124.58]:14722 "EHLO
	mail.dvmed.net") by vger.kernel.org with ESMTP id S261290AbVDZE6i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 00:58:38 -0400
Message-ID: <426DCA75.901@pobox.com>
Date: Tue, 26 Apr 2005 00:58:29 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: pasky@ucw.cz, git@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Cogito-0.8 (former git-pasky, big changes!)
References: <20050426032422.GQ13467@pasky.ji.cz>
In-Reply-To: <20050426032422.GQ13467@pasky.ji.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Baudis wrote:
>   Hello,
> 
>   here goes Cogito-0.8, my SCMish layer over Linus Torvald's git tree
> history tracker. This package was formerly called git-pasky, however
> this release brings big changes. The usage is significantly different,
> as well as some basic concepts; the history changed again (hopefully the
> last time?) because of fixing dates of some old commits. The .git/
> directory layout changed too.

tar xvfj $x
cd x
make
...
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o rpull rpull.c 
libgit.a rsh.c -lz -lssl
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o rev-list rev-list.c 
libgit.a -lz -lssl
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-mktag 
git-mktag.c libgit.a -lz -lssl
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o diff-tree-helper 
diff-tree-helper.c libgit.a -lz -lssl
make: commit-id: Command not found
Generating cg-version...



So, it still complains about commit-id

	Jeff


