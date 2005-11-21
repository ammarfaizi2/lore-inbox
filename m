Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbVKUWrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbVKUWrW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbVKUWrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:47:21 -0500
Received: from silver.veritas.com ([143.127.12.111]:9896 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751190AbVKUWrU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:47:20 -0500
Date: Mon, 21 Nov 2005 22:40:30 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: tiwai@suse.de, rmk+lkml@arm.linux.org.uk, wli@holomorphy.com,
       davem@davemloft.net, torvalds@osdl.org, nickpiggin@yahoo.com.au,
       airlied@gmail.com, linux-kernel@vger.kernel.org,
       alsa-devel@lists.sourceforge.net
Subject: Re: [PATCH 12/11] unpaged: fix sound Bad page states
In-Reply-To: <20051121124105.1bf8090d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0511212240060.21223@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511211801070.17464@goblin.wat.veritas.com>
 <20051121124105.1bf8090d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Nov 2005 22:40:24.0742 (UTC) FILETIME=[901CB460:01C5EEEC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2005, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> >
> >   arch/sparc/kernel/ioport.c |    2 +-
> >   arch/sparc64/kernel/sbus.c |    2 +-
> >   sound/core/memalloc.c      |    2 ++
> >   3 files changed, 4 insertions(+), 2 deletions(-)
> 
> So with this, do you think everything is in place for a mainline merge?

Yes, I believe so: thanks.

Hugh
