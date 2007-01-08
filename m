Return-Path: <linux-kernel-owner+w=401wt.eu-S1751454AbXAHGiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbXAHGiZ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 01:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbXAHGiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 01:38:25 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:54962 "EHLO
	pne-smtpout1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751454AbXAHGiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 01:38:24 -0500
To: David Miller <davem@davemloft.net>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, kaber@trash.net
Subject: Re: Linux 2.6.20-rc4
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	<m37ivyr1v6.fsf@telia.com>
	<Pine.LNX.4.64.0701071442580.3661@woody.osdl.org>
	<20070107.170056.76564352.davem@davemloft.net>
From: Peter Osterlund <petero2@telia.com>
Date: 08 Jan 2007 07:38:18 +0100
In-Reply-To: <20070107.170056.76564352.davem@davemloft.net>
Message-ID: <m3y7oeowf9.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller <davem@davemloft.net> writes:

> From: Linus Torvalds <torvalds@osdl.org>
> Date: Sun, 7 Jan 2007 14:50:15 -0800 (PST)
> 
> > David, there really *is* something screwy in netfilter. 
> 
> Sure, but from what I can see this bug appears unrelated to the one in
> kernel bugzilla #7781 that we've been discussing the past few days.
> 
> First of all, the nf conntrack paths won't be used by normal
> users until 2.6.20-rc1 or so.  The bz #7781 report is against
> 2.6.19 and all those backtraces have IP conntrack in them, not
> nf conntrack.
> 
> So what are we compiling with here btw, gcc-4.1?

"gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)" from Fedora Core 5.
That distribution has gcc32 installed too, so I'll try that compiler
too and report back.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
