Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261416AbSJUP4a>; Mon, 21 Oct 2002 11:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261454AbSJUP4a>; Mon, 21 Oct 2002 11:56:30 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:56756 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261416AbSJUP42>; Mon, 21 Oct 2002 11:56:28 -0400
Subject: Re: [PATCH] Add generic prefetch xor routines
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021021152101.I5285@parcelfarce.linux.theplanet.co.uk>
References: <20021017180134.X15163@parcelfarce.linux.theplanet.co.uk>
	<20021017172729.GA29177@suse.de>
	<1035209312.27309.121.camel@irongate.swansea.linux.org.uk> 
	<20021021152101.I5285@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 17:18:15 +0100
Message-Id: <1035217095.27259.198.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-21 at 15:21, Matthew Wilcox wrote:
> > Yes I reported this to Matthew ages ago, but its not been fixed. Thats
> > why I've not been merging that change anywhere.
> 
> How about this patch then?

Nice. Scores double points for a duffs device in line code, special
bonus for all of that sometimes being in a macro 8). Consider becoming
an XFree86 hacker

I guess the only remaining thing is the question of honouring the
suggested prefetch range but thats not a correctness item even

