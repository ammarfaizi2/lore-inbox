Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269124AbTGORWx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269140AbTGORWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:22:53 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:29707 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S269124AbTGORWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 13:22:21 -0400
Date: Tue, 15 Jul 2003 18:38:39 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: ACPI-Devel mailing list <acpi-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>, Len Brown <lenb417@yahoo.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: RE: ACPI patches updated (20030714)
In-Reply-To: <F760B14C9561B941B89469F59BA3A8470255EE8F@orsmsx401.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0307151832520.7904-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jul 2003, Grover, Andrew wrote:
> > From: Hugh Dickins [mailto:hugh@veritas.com] 
> > > Make it so acpismp=force works (reported by Andrew Morton)
> > 
> > But we don't want "acpismp=force" to work, it now serves no purpose
> > but to confuse.  May I push again to Marcelo my patch you acked
> > before, which removes it completely?  I had been waiting to say it's
> > in 2.6, but Andrew didn't push it from 2.5-mm into 2.6 - any reason?
> > 
> > Whereas we would still like "noht" to work, but it's now beyond me.
> 
> That patch was sitting in my bk tree but yeah it's kinda stale. Len
> Brown was going to completely redo all this stuff, so Hugh if you have a
> need for your fix in the interim then great feel free to push, but there
> is a more comprehensive fix also in the works.

I've no desperate need to push it, can easily apply the patch to my own
tree.  It's just that Marcelo is motoring so speedily towards 2.4.22,
be a shame if that goes out with CONFIG_ACPI_HT_ONLY needing pointless
"acpismp=force" too.  What's the schedule for Len's rework to Marcelo?

Hugh

