Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965260AbWADS0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965260AbWADS0K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 13:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965259AbWADS0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 13:26:10 -0500
Received: from solarneutrino.net ([66.199.224.43]:4612 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S965257AbWADS0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 13:26:09 -0500
Date: Wed, 4 Jan 2006 13:26:05 -0500
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, ryan@tau.solarneutrino.net
Subject: Re: Fw: crash on x86_64 - mm related?
Message-ID: <20060104182605.GA397@tau.solarneutrino.net>
References: <Pine.LNX.4.61.0512071803300.2975@goblin.wat.veritas.com> <20051212165443.GD17295@tau.solarneutrino.net> <Pine.LNX.4.64.0512120928110.15597@g5.osdl.org> <1134409531.9994.13.camel@mulgrave> <Pine.LNX.4.64.0512121007220.15597@g5.osdl.org> <1134411882.9994.18.camel@mulgrave> <20051215190930.GA20156@tau.solarneutrino.net> <1134705703.3906.1.camel@mulgrave> <20051226234238.GA28037@tau.solarneutrino.net> <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2005 at 06:21:39PM +0200, Kai Makisara wrote:
> Running dump gave me the following output:

In case it's interesting, here's what I got from flushing the unfinished
backup to tape:

st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff8100f6eb4520 mapcount:2 count:4 pfn:981656
 1: flags:0x010000000000006c mapping:ffff8100f6eb4520 mapcount:2 count:4 pfn:981657
 2: flags:0x010000000000006c mapping:ffff8100f6eb4520 mapcount:2 count:4 pfn:981658
 3: flags:0x010000000000006c mapping:ffff8100f6eb4520 mapcount:2 count:4 pfn:981659
 4: flags:0x010000000000006c mapping:ffff8100f6eb4520 mapcount:2 count:4 pfn:981660
 5: flags:0x010000000000006c mapping:ffff8100f6eb4520 mapcount:2 count:4 pfn:981661
 6: flags:0x010000000000006c mapping:ffff8100f6eb4520 mapcount:2 count:4 pfn:981662
 7: flags:0x010000000000006c mapping:ffff8100f6eb4520 mapcount:2 count:4 pfn:981663

No crash this time.

-ryan
