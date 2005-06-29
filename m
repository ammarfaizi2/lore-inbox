Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVF2PVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVF2PVs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 11:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVF2PVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 11:21:48 -0400
Received: from sommereik.ii.uib.no ([129.177.16.236]:29677 "EHLO
	sommereik.ii.uib.no") by vger.kernel.org with ESMTP id S261338AbVF2PVq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 11:21:46 -0400
Subject: Re: Linux 2.6.13-rc1
From: "Ronny V. Vindenes" <s864@ii.uib.no>
To: Hugh Dickins <hugh@veritas.com>
Cc: Tomasz Torcz <zdzichu@irc.pl>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0506291604340.14413@goblin.wat.veritas.com>
References: <4kEoS-Am-3@gated-at.bofh.it>
	 <m37jgd9r8w.fsf@localhost.localdomain> <20050629145806.GA5803@irc.pl>
	 <Pine.LNX.4.61.0506291604340.14413@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 17:20:45 +0200
Message-Id: <1120058445.3463.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-11.fc5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ons, 29,.06.2005 kl. 16.07 +0100, skrev Hugh Dickins:
> On Wed, 29 Jun 2005, Tomasz Torcz wrote:
> > On Wed, Jun 29, 2005 at 04:23:11PM +0200, Ronny V. Vindenes wrote:
> > > 
> > > On x86_64 with reiserfs and ext3 on dm (using cfq scheduler) the log
> > > is full of this:
> > > 
> > > Badness in blk_remove_plug at drivers/block/ll_rw_blk.c:1424
> > 
> >  Also on x86, Reiserfs on LVM2, cfq, on sata_sil; Preemption set to
> > Voluntary.
> 
> You should find the patch I posted just a little earlier fixes all that...

Confirmed.

-- 
Ronny V. Vindenes <s864@ii.uib.no>

