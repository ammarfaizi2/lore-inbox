Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161002AbWBHGiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbWBHGiR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030573AbWBHGiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:38:17 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:53522 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1030569AbWBHGiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:38:17 -0500
Date: Wed, 8 Feb 2006 07:37:54 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: Roberto Nibali <ratz@drugphish.ch>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
Message-ID: <20060208063754.GA13668@w.ods.org>
References: <Pine.LNX.4.64.0601070246150.29898@potato.cts.ucla.edu> <43C2C482.6090904@drugphish.ch> <Pine.LNX.4.64.0601091221260.1900@potato.cts.ucla.edu> <43C2E243.5000904@drugphish.ch> <Pine.LNX.4.64.0601091654380.6479@potato.cts.ucla.edu> <Pine.LNX.4.64.0601150322020.5053@potato.cts.ucla.edu> <Pine.LNX.4.64.0601151431250.5053@potato.cts.ucla.edu> <20060115224642.GA10069@w.ods.org> <Pine.LNX.4.64.0601151452460.5053@potato.cts.ucla.edu> <Pine.LNX.4.64.0602072228500.3253@potato.cts.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602072228500.3253@potato.cts.ucla.edu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 10:32:45PM -0800, Chris Stromsoe wrote:
> On Sun, 15 Jan 2006, Chris Stromsoe wrote:
> >On Sun, 15 Jan 2006, Willy TARREAU wrote:
> >>
> >>Thanks for the precision. So logically we should expect it to break 
> >>sooner or later ?
> >
> >It is the same .config as one that crashed before, except that it has 
> >DEBUG_SLAB defined.  If it does not crash, then adding pci=noacpi to the 
> >command fixes the problem for me.
> 
> For what it's worth, I'm fairly certain at this point that the problem 
> was hardware related.  After a week of uptime with 2.6 we had another pmd 
> error and oops.  We then replaced the system board and one of the CPUs 
> and have not seen any problems since.

Chris, thank you very much for this useful feedback. Now we're sure that
it's not worth investigating on the aic7xxx driver for any potential
memory corruption bug.

> -Chris

Regards,
Willy

