Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276121AbRI1PXU>; Fri, 28 Sep 2001 11:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276122AbRI1PXI>; Fri, 28 Sep 2001 11:23:08 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:59295 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S276121AbRI1PW6>; Fri, 28 Sep 2001 11:22:58 -0400
Date: Fri, 28 Sep 2001 16:23:24 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: Chris Mason <mason@suse.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: weirdness in reiserfs
In-Reply-To: <643320000.1001689341@tiny>
Message-ID: <Pine.LNX.4.33.0109281609580.10065-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:02 -0400 Chris Mason wrote:

[ 2.4.9-ac10ish.. slow deleting of 25GB, horrible latency ]
>
>Hmmm, I'd be curious to see how 2.4.9-ac16 (or 2.4.10) performs there.  The
>reiserfs delete code should be scheduling enough due to transaction
>stop/starts that interactive performance isn't that bad.

Will check both of you suggestions over the next few days, thanks!

>You should be able to repeat your results by doing the same tests on sparse
>files:
>
>dd if=/dev/zero of=foo bs=1M count=1 seek=250000

