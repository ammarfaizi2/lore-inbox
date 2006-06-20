Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWFTPRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWFTPRB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 11:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWFTPRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 11:17:01 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:49830 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751309AbWFTPRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 11:17:00 -0400
Date: Tue, 20 Jun 2006 17:16:58 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Jean-Daniel Pauget <jd@disjunkt.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>,
       bert hubert <bert.hubert@netherlabs.nl>, george@mvista.com
Subject: Re: Linux 2.6.17: PM-Timer bug warning?
Message-ID: <20060620151658.GA5230@rhlx01.fht-esslingen.de>
References: <20060620100800.GB5040@disjunkt.com> <20060620101946.GA32658@rhlx01.fht-esslingen.de> <87zmg7q3gm.fsf@duaron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zmg7q3gm.fsf@duaron.myhome.or.jp>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 20, 2006 at 11:58:01PM +0900, OGAWA Hirofumi wrote:
> Andreas Mohr <andi@rhlx01.fht-esslingen.de> writes:
> 
> >>     but now, how and to whom should I report ?
> >
> > We need to enhance current kernel to whitelist this chipset revision
> > somehow. Or at least put a note there that this revision is ok, too
> > (to wait some more time for further evidence/revisions to appear).
> 
> Almost ICH4 should be sane.  Since there seems both reports of good
> and bad, probably the bug of ICH4 seems to be depending on a specific
> motherboard.
> 
> FWIW, If you want to reduce gray-list, probably it should be
> motherboard list.

OK, so if I get a nice description of which dual P4 Xeon motherboard that
was (Dell something?), then I'll make a patch adding
this chipset's revision + motherboard + LKML link of bug test app
to the file, and asking for more testers there, too.

Andreas Mohr

-- 
No programming skills!? Why not help translate many Linux applications! 
https://launchpad.ubuntu.com/rosetta
(or alternatively buy nicely packaged Linux distros/OSS software to help
support Linux developers creating shiny new things for you?)
