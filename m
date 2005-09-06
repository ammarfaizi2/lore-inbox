Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbVIFSaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbVIFSaN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 14:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbVIFSaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 14:30:13 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:32480 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1750779AbVIFSaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 14:30:12 -0400
Date: Tue, 6 Sep 2005 14:30:08 -0400
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Bret Towe <magnade@gmail.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs4 client bug
Message-ID: <20050906183008.GG10632@fieldses.org>
References: <dda83e78050904124454fc675a@mail.gmail.com> <dda83e78050904135113b95c4a@mail.gmail.com> <20050904215219.GA9812@fieldses.org> <dda83e780509042008294fbe26@mail.gmail.com> <20050905031825.GA22209@fieldses.org> <dda83e78050905134420f06fbf@mail.gmail.com> <9a87484905090513481118e67b@mail.gmail.com> <dda83e7805090520407aefb4d1@mail.gmail.com> <20050906181327.GE10632@fieldses.org> <Pine.LNX.4.50.0509061119380.19596-100000@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0509061119380.19596-100000@shark.he.net>
User-Agent: Mutt/1.5.10i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 11:21:09AM -0700, Randy.Dunlap wrote:
> On Tue, 6 Sep 2005, J. Bruce Fields wrote:
> 
> > On Mon, Sep 05, 2005 at 08:40:53PM -0700, Bret Towe wrote:
> > > Pid: 14169, comm: xmms Tainted: G   M  2.6.13
> >
> > Hm, can someone explain what that means?  A proprietary module was
> > loaded then unloaded, maybe?
> 
> 'M' means Machine Check, which sets the Tainted flag.
> So the processor thought that there was some kind of problem.

Does this NMI watchdog event ("NMI Watchdog detected LOCKUP on CPU0CPU
0") set that flag?

> (/we needs to update Documentation/oops-tracing.txt)

Oops, thanks, I overlooked that!

--b.
