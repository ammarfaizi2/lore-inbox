Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbVAECF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbVAECF4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 21:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVAECFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 21:05:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:16834 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262185AbVAECFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 21:05:47 -0500
Date: Tue, 4 Jan 2005 18:05:43 -0800
From: Chris Wright <chrisw@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Chris Wright <chrisw@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Jack O'Quin" <joq@io.com>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050104180541.P2357@build.pdx.osdl.net>
References: <1104374603.9732.32.camel@krustophenia.net> <20050103140359.GA19976@infradead.org> <1104862614.8255.1.camel@krustophenia.net> <20050104182010.GA15254@infradead.org> <87u0pxhvn0.fsf@sulphur.joq.us> <1104865198.8346.8.camel@krustophenia.net> <1104878646.17166.63.camel@localhost.localdomain> <20050104175043.H469@build.pdx.osdl.net> <1104890131.18410.32.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1104890131.18410.32.camel@krustophenia.net>; from rlrevell@joe-job.com on Tue, Jan 04, 2005 at 08:55:31PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell (rlrevell@joe-job.com) wrote:
> The last time I checked users could belong to more than one group.  Am I
> missing something?

No, you're not.  I think Alan's just saying the gid based checks
are suboptimal if there's a cleaner way to do it (to which I agree).
Personally, I don't have a big problem with the Realtime LSM.  I've helped
you with it, and suggested a few times that I'd prefer it to be generic;
but never stepped up to deliver code of that sort.  Since it's your itch,
you've scratched it, and it's quite simple and contained, I consider
it acceptable.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
