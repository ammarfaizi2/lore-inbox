Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267903AbUHXUNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267903AbUHXUNe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 16:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268262AbUHXUNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 16:13:34 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:16259 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267903AbUHXUNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 16:13:30 -0400
Subject: Re: Linux 2.6.9-rc1
From: Josh Boyer <jdub@us.ibm.com>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <871xhwb9c6.fsf@deneb.enyo.de>
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
	 <20040824184245.GE5414@waste.org>
	 <Pine.LNX.4.58.0408241221390.17766@ppc970.osdl.org>
	 <871xhwb9c6.fsf@deneb.enyo.de>
Content-Type: text/plain
Message-Id: <1093378401.2991.32.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 24 Aug 2004 15:13:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-24 at 14:54, Florian Weimer wrote:
> * Linus Torvalds:
> 
> > On Tue, 24 Aug 2004, Matt Mackall wrote:
> >> 
> >> Phew, I was worried about that. Can I get a ruling on how you intend
> >> to handle a x.y.z.1 to x.y.z.2 transition? I've got a tool that I'm
> >> looking to unbreak. My preference would be for all x.y.z.n patches to
> >> be relative to x.y.z.
> >
> > Hmm.. I have no strong preferences. There _is_ obviously a well-defined 
> > ordering from x.y.z.1 -> x.y.z.2 (unlike the -rcX releases that don't have 
> > any ordering wrt the bugfixes), so either interdiffs or whole new full 
> > diffs are totally "logical". We just have to chose one way or the other, 
> > and I don't actually much care.
> 
> It would be slightly more consistent to diff .2 against .1 because
> this is what already happens when a new x.y.z release is published.

Yes, but the -rcX releases aren't done that way.  It's mostly how you
view things.  From a users point of view, do I want to download x.y.z
and apply patches .1 through .N?  Or do I want to download x.y.z and
apply 1 patch to get me to the x.y.z.N level?

Personally, I prefer the "one patch to rule them all" method. :)

josh

