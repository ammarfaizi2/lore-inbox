Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268836AbUIHEYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268836AbUIHEYE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 00:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268182AbUIHEYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 00:24:04 -0400
Received: from pat.uio.no ([129.240.130.16]:19621 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S268861AbUIHEX4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 00:23:56 -0400
Subject: Re: [CHECKER] 2.6.8.1 deadlock in rpc_queue_lock <<===>> 
	rpc_sched_lock
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Greg Banks <gnb@melbourne.sgi.com>
Cc: Dawson Engler <engler@coverity.dreamhost.com>,
       linux-kernel@vger.kernel.org, developers@coverity.com
In-Reply-To: <1094615460.20243.165.camel@hole.melbourne.sgi.com>
References: <Pine.LNX.4.58.0409071915020.23546@coverity.dreamhost.com>
	 <1094615460.20243.165.camel@hole.melbourne.sgi.com>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1094617428.8389.12.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 08 Sep 2004 00:23:48 -0400
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På ty , 07/09/2004 klokka 23:51, skreiv Greg Banks:

> If this arc ever happens, you have data structure corruption issues
> which are far more worrying than a deadlock.

True, but we should still get rid of it. No point in maintaining buggy
debugging lines.

Note that in any case, the global rpc_queue_lock is gone in recent
NFS_ALL and 2.6.x-mm series patches.

Cheers,
   Trond

