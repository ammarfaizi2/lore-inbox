Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268003AbRGZPDA>; Thu, 26 Jul 2001 11:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268015AbRGZPCk>; Thu, 26 Jul 2001 11:02:40 -0400
Received: from ns.caldera.de ([212.34.180.1]:62852 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S268003AbRGZPC2>;
	Thu, 26 Jul 2001 11:02:28 -0400
Date: Thu, 26 Jul 2001 17:02:16 +0200
Message-Id: <200107261502.f6QF2Go10488@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@zip.com.au>,
        lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: ext3-2.4-0.9.4
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20010726164516.R17244@emma1.emma.line.org>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In article <20010726164516.R17244@emma1.emma.line.org> you wrote:
> On Thu, 26 Jul 2001, Rik van Riel wrote:
>
>> An MTA which relies on this is therefore Broken(tm).

> MTAs rely on TRULY, ULTIMATELY AND DEFINITELY SYNCHRONOUS directory
> updates, nothing else.

And thus they are broken, all caps don't make that less true.

> And because they do so, and most systems have them,

"and most systems have them"...

> MTAs do NOT care how the file system is internally managed, they only
> rely on the rename operation having completed physically on disk before
> the "my rename call has returned 0" event. They expect that with the
> call returning the rename operation has completed ultimately, finally,
> for good, definitely and the old file will not reappear after a crash.

So they rely on undocumented and non standadisized semantics of some
implementations.  I'd call this buggy.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
