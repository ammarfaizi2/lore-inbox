Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268968AbUIMVYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268968AbUIMVYI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 17:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268966AbUIMVYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 17:24:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:30632 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268972AbUIMVXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 17:23:52 -0400
Date: Mon, 13 Sep 2004 14:23:47 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Christian Borntraeger <linux-kernel@borntraeger.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: Linux 2.6.9-rc2 : oops
In-Reply-To: <200409132315.36577.linux-kernel@borntraeger.net>
Message-ID: <Pine.LNX.4.58.0409131422530.2378@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409130937050.4094@ppc970.osdl.org>
 <200409132203.08286.linux-kernel@borntraeger.net>
 <Pine.LNX.4.58.0409131318320.2378@ppc970.osdl.org>
 <200409132315.36577.linux-kernel@borntraeger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Sep 2004, Christian Borntraeger wrote:
> 
> reversing "[PATCH] Fix leaks in ISOFS."
> http://linux.bkbits.net:8080/linux-2.6/cset%40413792bdlE_TiqzIHELio3xcG68QeQ
> helps. Seems we need a fix for the fix. 

Andrew posted one already, which looks "obviously correct". Can you undo 
your revert, and try that one? I've already applied it to BK, so if you're 
on BK you can just pull from the current repo's.

Thanks,

		Linus
