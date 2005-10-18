Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbVJRIXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbVJRIXa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 04:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbVJRIXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 04:23:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:35024 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751465AbVJRIXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 04:23:30 -0400
From: Andi Kleen <ak@suse.de>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: Re: x86_64: 2.6.14-rc4 swiotlb broken
Date: Tue, 18 Oct 2005 10:23:51 +0200
User-Agent: KMail/1.8
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, tglx@linutronix.de,
       shai@scalex86.org
References: <20051017093654.GA7652@localhost.localdomain> <Pine.LNX.4.64.0510171405510.3369@g5.osdl.org> <20051018001620.GD8932@localhost.localdomain>
In-Reply-To: <20051018001620.GD8932@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510181023.52074.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 October 2005 02:16, Ravikiran G Thirumalai wrote:
> On Mon, Oct 17, 2005 at 02:11:20PM -0700, Linus Torvalds wrote:
> > On Mon, 17 Oct 2005, Andrew Morton wrote:
> > > There seem to be a lot of proposed solutions floating about and I fear
> > > that different people will try to fix this in different ways.  Do we
> > > all agree that this patch is the correct solution to this problem, or
> > > is something more needed?
> >
> > I think this will fix it.
>
> I just tried Yasunori-sans patch on our x460.  It doesn't fix the problem.

That's surprising. Can you post the full boot log? The nodes should be really 
in order. Maybe we need to sort the SRAT first.

-Andi

