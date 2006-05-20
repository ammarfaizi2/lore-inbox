Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWETWPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWETWPl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 18:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWETWPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 18:15:40 -0400
Received: from cantor.suse.de ([195.135.220.2]:19430 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932401AbWETWPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 18:15:39 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [git patches] net driver updates
Date: Sun, 21 May 2006 00:15:15 +0200
User-Agent: KMail/1.9.1
Cc: Linus Torvalds <torvalds@osdl.org>, jeff@garzik.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Manfred Spraul <manfred@colorfullife.com>,
       Ayaz Abdulla <aabdulla@nvidia.com>
References: <20060520042856.GA7218@havoc.gtf.org> <Pine.LNX.4.64.0605201035510.10823@g5.osdl.org> <20060520105547.220f2bea.akpm@osdl.org>
In-Reply-To: <20060520105547.220f2bea.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605210015.15847.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 May 2006 19:55, Andrew Morton wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> >
> > 
> > 
> > On Sat, 20 May 2006, Andrew Morton wrote:
> > > Jeff Garzik <jeff@garzik.org> wrote:
> > > >
> > > > Andrew Morton:
> > > >        revert "forcedeth: fix multi irq issues"
> > > 
> > > Manfred just found the fix for this, so we should no longer need to revert.
> > 
> > Hmm. I already pulled. I guess we can revert the revert and apply 
> > Manfreds fix. Jeff?
> > 
> 
> I can cook up the necessary pieces.

My NF4Pro machine now reliably does

Disconnecting: Bad packet length 3742984839.

when I display a lot of data through ssh.  Apparently it generates some 
corruption that's not caught by the TCP checksum. Would that be fixed by this
change too? 

-Andi

