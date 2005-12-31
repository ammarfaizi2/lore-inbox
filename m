Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbVLaIdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbVLaIdi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 03:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbVLaIdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 03:33:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48560 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751053AbVLaIdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 03:33:37 -0500
Subject: Re: userspace breakage
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, davej@redhat.com,
       jmerkey@wolfmountaingroup.com
In-Reply-To: <20051230154954.47be93a3.akpm@osdl.org>
References: <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
	 <1135798495.2935.29.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
	 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
	 <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu>
	 <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org>
	 <20051229202852.GE12056@redhat.com>
	 <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org>
	 <20051229224103.GF12056@redhat.com>
	 <43B453CA.9090005@wolfmountaingroup.com>
	 <Pine.LNX.4.64.0512291541420.3298@g5.osdl.org>
	 <43B46078.1080805@wolfmountaingroup.com>
	 <Pine.LNX.4.64.0512291603500.3298@g5.osdl.org>
	 <1135974176.6039.71.camel@localhost.localdomain>
	 <20051230154954.47be93a3.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 31 Dec 2005 09:33:29 +0100
Message-Id: <1136018010.2901.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 15:49 -0800, Andrew Morton wrote:
> Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Thu, 2005-12-29 at 16:10 -0800, Linus Torvalds wrote:
> > 
> > > Stuff outside the kernel is almost always either (a) experimental stuff 
> > > that just isn't ready to be merged or (b) tries to avoid the GPL.
> > 
> > (c) So damn specialized that it's not worth even trying to merge.
> 
> Or drivers for highly specialised/customised hardware.

that's not really an excuse.. there's drivers in the tree for which only
4 boards ever existed. There still is value in having those in the tree,
if only for the "other side" of the API to be able to see usage
patterns...


