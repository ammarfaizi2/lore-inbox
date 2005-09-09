Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbVIIMAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVIIMAq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 08:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbVIIMAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 08:00:46 -0400
Received: from silver.veritas.com ([143.127.12.111]:34715 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751368AbVIIMAp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 08:00:45 -0400
Date: Fri, 9 Sep 2005 13:00:34 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andi Kleen <ak@suse.de>
cc: discuss@x86-64.org, Jan Beulich <JBeulich@novell.com>,
       Keith Owens <kaos@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [discuss] [PATCH] allow CONFIG_FRAME_POINTER for x86-64
In-Reply-To: <200509091342.12517.ak@suse.de>
Message-ID: <Pine.LNX.4.61.0509091256430.6894@goblin.wat.veritas.com>
References: <43207D28020000780002451E@emea1-mh.id2.novell.com>
 <20050909112108.GK19913@wotan.suse.de> <Pine.LNX.4.61.0509091222310.6443@goblin.wat.veritas.com>
 <200509091342.12517.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Sep 2005 12:00:45.0199 (UTC) FILETIME=[1BF771F0:01C5B536]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sep 2005, Andi Kleen wrote:
> On Friday 09 September 2005 13:31, Hugh Dickins wrote:
> > On Fri, 9 Sep 2005, Andi Kleen wrote:
> > > But kdb should be using a dwarf2 unwinder instead. kgdb certainly
> > > supports that, as does NLKD.
> >
> > In an ideal and bloat-neutral world.  I've always imagined it to be
> > quite a lot of work, bringing in its own set of problems: but great
> > that that work has now been done, and yes, it might one day get
> > ported to kdb.  But removing "&& !X86_64" is much easier.
> 
> Hmm ok. I will do that change.

Thanks, Andi.

Hugh
