Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293218AbSCaOvX>; Sun, 31 Mar 2002 09:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293314AbSCaOvN>; Sun, 31 Mar 2002 09:51:13 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:7208 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S293218AbSCaOvH>; Sun, 31 Mar 2002 09:51:07 -0500
Date: Sun, 31 Mar 2002 16:51:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, gerrit@us.ibm.com
Subject: Re: Backport of Ingo/Arjan highpte to 2.4.18 (+O1 scheduler)
Message-ID: <20020331165101.B1331@dualathlon.random>
In-Reply-To: <242250000.1016752254@flay> <20020326180841.C13052@dualathlon.random> <13110000.1017442147@flay> <20020330204444.A1264@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2002 at 08:44:44PM +0100, Andrea Arcangeli wrote:
> just fine on top of pre4).  I was ready to release it today (just
> running for one day of stress testing), but pre5 came out so I'll have
> to spend some more hour to slowly resync and rediff.

Ok, after a few hours of a very pleasant resyncing work and re-testing
(it was great to see lots of good stuff integrated from Marcelo) it's
out right now.  If you could retest the NUMA-Q support on top of
2.4.19pre5aa1 that would be helpful to know if the presistent kmap is a
problem in mremap (the place where it's currently buggy in 2.5). Thanks!

Andrea
