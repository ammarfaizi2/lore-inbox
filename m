Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264026AbTFDUEE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 16:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264028AbTFDUEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 16:04:04 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:60313 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S264026AbTFDUEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 16:04:02 -0400
Date: Wed, 4 Jun 2003 22:16:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: hugang <hugang@soulinfo.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE Power Management (Was: software suspend in 2.5.70-mm3)
Message-ID: <20030604201652.GC524@elf.ucw.cz>
References: <20030603211156.726366e7.hugang@soulinfo.com> <1054646566.9234.20.camel@dhcp22.swansea.linux.org.uk> <20030603223511.155ea2cc.hugang@soulinfo.com> <1054649308.9233.26.camel@dhcp22.swansea.linux.org.uk> <1054659866.20839.10.camel@gaston> <1054732481.20839.30.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054732481.20839.30.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Still races. Ben's stuff is needed
> > 
> > I have it working with some fixes from what I sent earlier, I'll
> > repost that tonight or tomorrow, I need to extract that from
> > a half-broken tree ;)
> 
> Ok, here is it. It still need a bit of cleanup (removal of magic
> number for "steps" -> enum, etc...) and we may want to do more
> things on wakeup especially for ide-cd, Also I don't deal with
> ide-tape or ide-floppy in there and haven't fully studied the
> impact with ide-scsi....
> 
> So it's not meant to be merged as-is, though I'd appreciate to
> know if it helps for you.
> 
> Bartolomiej: Any comments appreciated, I won't do the ide-tape/floppy
> part as I don't know/own these, I think i'll let you decide if
> anything more is needed on the wakeup path for ide-cd... Once I
> have enough feedback, I'll send you a cleanified version as
> candidate for upstream merge.

Please send cleaned up version ASAP... Waiting will do no good. If it
handles only ide-disks, that's okay, its still way better than whats
in the tree.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
