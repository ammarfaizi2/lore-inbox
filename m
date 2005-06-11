Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVFKSdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVFKSdG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 14:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVFKSdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 14:33:06 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16516 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261775AbVFKSc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 14:32:56 -0400
Date: Sat, 11 Jun 2005 19:32:46 +0100
From: jgarzik@pentafluge.infradead.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Jeff Garzik <jgarzik@pobox.com>,
       mike.miller@hp.com, akpm@osdl.org, axboe@suse.de,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: DMA mapping (was Re: [PATCH] cciss 2.6; replaces DMA masks with kernel defines)
Message-ID: <20050611183246.GA3019@pentafluge.infradead.org>
References: <20050610143453.GA26476@beardog.cca.cpqcorp.net> <42A9C60E.3080604@pobox.com> <1118436000.6423.42.camel@mindpipe> <1118436306.5272.37.camel@laptopd505.fenrus.org> <1118436589.6423.51.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118436589.6423.51.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 04:49:48PM -0400, Lee Revell wrote:
> On Fri, 2005-06-10 at 22:45 +0200, Arjan van de Ven wrote: 
> > > Why doesn't this file define 29, 30, 31 bit DMA masks, required by many
> > > devices?  I know of at least 2 soundcards that need a 29 bit DMA mask.
> > 
> > your mail unfortunately was not in diff -u form ;)
> > I'm pretty sure that such constants are welcome
> > 
> 
> OK, I just wanted to see if there was a reason before posting it.
> 
> Anyone know of hardware that needs less than a 29 bit mask?

ALS2000 sound device, which is basically an ISA SB chip on a PCI board.

	Jeff



