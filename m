Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132051AbRAEPdE>; Fri, 5 Jan 2001 10:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131964AbRAEPcy>; Fri, 5 Jan 2001 10:32:54 -0500
Received: from mail.zmailer.org ([194.252.70.162]:28684 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129523AbRAEPco>;
	Fri, 5 Jan 2001 10:32:44 -0500
Date: Fri, 5 Jan 2001 17:32:30 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 todo list update
Message-ID: <20010105173230.O12545@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.21.0101051244440.1295-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0101051244440.1295-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Fri, Jan 05, 2001 at 12:58:34PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2001 at 12:58:34PM -0200, Rik van Riel wrote:
> Hi Ted,
> 
> in the last few weeks quite a few of the bugs listed on your
> (excellent) http://linux24.sourceforge.net/ have been fixed.

Adding to Rik's items, other things I spot at that "old" list
having changed over last 6 weeks, or so:

o Various Alpha's don't boot under 2.4.0-test9 (PCI-PCI bridge init issues)
o Alpha SMP problem: RSN reuse

	I assume that latter is typo and in reality ASN reuse.
	Fixes got merged during the preprelease-diffs

o Restore O_SYNC functionality ...
o Forwawrd port 2.2 fixes to allow 2 GHz or faster CPU's. {CRITICAL} 

	Also folded in during prerelease-diffs


o mtrr.c is broken for machines with >= 4GB of memory (David Wragg has a fix)

	Merged in at test12 or test13, I think.

o devfs and NFS problems

	fixes are also aplenty over last 6 weeks.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
