Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288289AbSACTEl>; Thu, 3 Jan 2002 14:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288258AbSACTEb>; Thu, 3 Jan 2002 14:04:31 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:44039 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287303AbSACTE0>; Thu, 3 Jan 2002 14:04:26 -0500
Message-ID: <3C34AA0B.3D4B2891@zip.com.au>
Date: Thu, 03 Jan 2002 10:59:23 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "M. Edward Borasky" <znmeb@aracnet.com>, Art Hays <art@lsr.nei.nih.gov>,
        linux-kernel@vger.kernel.org
Subject: Re: kswapd etc hogging machine
In-Reply-To: <3C33E8EA.FAF8E337@zip.com.au> from "Andrew Morton" at Jan 02, 2002 09:15:22 PM <E16M72b-0008B8-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > But Art's kernel (what kernel is in RH7.2 anyway?  2.4.9 with vendor
> > hacks^Wfixes, I think) is nowhere near that stage.
> 
> 7.2 is 2.4.7-ac ish, 7.2 + errata is 2.4.9-ac ish

OK, thanks.

> > The good news is that 2.4.17 has pretty much slain this dragon.  The
> > -aa patches are better still, and 2.4.18 will be even better than
> > that.
> 
> Bollocks. I get regular mails from large numbers of people who are stuck
> at 2.4.12/13-ac and are hoping I'll do an update because their machines
> die in hours or run 25-50% slower with 2.4.1x.

I was referring to the swap and evict in the presence of heavy write
traffic.

> 2.4.1x VM code is performing better under light loads but its absolutely
> and completely hopeless under a real paging load. 2.4.17-aa is somewhat
> better interestingly.
> 

s/interestingly/frustratingly/.  -aa has some interesting changes to
the write scheduling as well.  I just wish I knew what problem they're
solving.

-
