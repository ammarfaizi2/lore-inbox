Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265218AbUGCSKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265218AbUGCSKu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 14:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265219AbUGCSKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 14:10:50 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:57967 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S265218AbUGCSKs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 14:10:48 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [uml-devel] Uploaded Uml patchset for 2.6.7(was: Re: Inclusion of UML in 2.6.8)
Date: Sat, 3 Jul 2004 20:25:18 +0200
User-Agent: KMail/1.5
Cc: user-mode-linux-devel@lists.sourceforge.net, Chris Wedgwood <cw@f00f.org>
References: <200406261905.22710.blaisorblade_spam@yahoo.it> <20040627035311.GA8842@ccure.user-mode-linux.org> <200406292129.52093.blaisorblade_spam@yahoo.it>
In-Reply-To: <200406292129.52093.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200406302105.09201.blaisorblade_spam@yahoo.it>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 21:29, martedì 29 giugno 2004, BlaisorBlade ha scritto:
> Alle 05:53, domenica 27 giugno 2004, Jeff Dike ha scritto:
> > On Sat, Jun 26, 2004 at 07:10:48PM +0100, Christoph Hellwig wrote:
> > > Please send split patches.  E.g. linux/ghash.h should not ne
> > > reintroduced, it's completely fuly.
>
> Anyway, I'm going to upload the whole patchset (as it is now); I just
> tarred my ./patch-scripts folder, containing descriptions, .pc files and
> actual patches. The updates from Jeff Dike are not very split, but
> everything I've added is in his own separate patch. Little changes anyway.
>
> I've problems with patch-bomb, so for now here is it:
>
> http://www.user-mode-linux.org/~blaisorblade/patches/bb/uml-patch-2.6.7-01-
>bb2.tar.bz2

I forgot 2 things: first - it's against 2.6.7 vanillla. Second - there are 
some not-working patches, but the "series" file does not refer to them.

So, 

tar xjf linux-2.6.7.tar.bz2
cd linux-2.6.7
tar xjf uml-patch-2.6.7-01-bb2.tar.bz2
pushpatch 30 (having patch-scripts installed)

is the simplest way to apply it. Without patch-scripts, for each line in 
patch-scripts/series (do grep -v '^#' first to remove comments) apply the 
patch from patch-scripts/patches.

Also, Andrew, why has it not been included in 2.6.7-mm5?
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


