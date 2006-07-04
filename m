Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWGDKDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWGDKDh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 06:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWGDKDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 06:03:37 -0400
Received: from aun.it.uu.se ([130.238.12.36]:35810 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932198AbWGDKDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 06:03:37 -0400
Date: Tue, 4 Jul 2006 12:03:19 +0200 (MEST)
Message-Id: <200607041003.k64A3JEL029677@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: mikpe@it.uu.se, rene@exactcode.de
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2006 11:32:31 +0200, Rene Rebe wrote:
> On Tuesday 04 July 2006 09:41, Rene Rebe wrote:
> 
> > On Monday 03 July 2006 13:17, Mikael Pettersson wrote:
> > > In 2.6.17 sparc64 kernels, X11 runs _extremely_ slowly with
> > > frequent lock-up like behaviour on my Ultra5 (ATI Mach64).
> > > I finally managed to trace the cause to this change in 2.6.16-git6:
> > 
> > I can confirm this behaviour, on a U5 with ATi onboard, but for me it
> > happens also on the Creator 3D of a U30, likewise.
> > 
> > I'll try to test if this changeset makes a difference for me as well
> > as soon as possible.
> 
> I can confirm that backing out this changeset fixes X on ATi@U5 as
> well as Creator3D@U30 to not stall and hang every few seconds for
> many more seconds/minutes.

Thanks.

/Mikael
