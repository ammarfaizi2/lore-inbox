Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262824AbUK0CtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbUK0CtZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263049AbUK0CFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 21:05:17 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262781AbUKZThS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:37:18 -0500
Date: Thu, 25 Nov 2004 13:29:02 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
       trond.myklebust@fys.uio.no, neilb@cse.unsw.edu.au, torvalds@osdl.org
Subject: Re: [PATCH] NFS mount hang fix
Message-ID: <20041125122902.GE27939@fi.muni.cz>
References: <20041026141148.GM6408@fi.muni.cz> <20041026150640.GA24881@fieldses.org> <20041027121543.GH4724@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027121543.GH4724@fi.muni.cz>
User-Agent: Mutt/1.4.2i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak wrote:
: J. Bruce Fields wrote:
: : Changing those buffers to static strikes me as potentially dangerous--we
: : currently call the ->parse() methods under a semaphore, so it's safe for
: : now, but that might change some day and then there'll be an ugly race
: : condition.
: : 
: : Could you check whether the following fixes your problem?--b.
: : 
: 	Yes, it is OK with this patch. Thanks,
: 
	It seems this patch did not make it into Linus' tree
(at least it is not in 2.6.10-rc2). Can you resend it to Linus, please?

	Thanks,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
