Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265172AbUATHP5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 02:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265225AbUATHP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 02:15:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:2702 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265172AbUATHPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 02:15:54 -0500
Date: Mon, 19 Jan 2004 23:15:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Xose Vazquez Perez <xose@wanadoo.es>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Tosatti <marcelo.tosatti@cyclades.com>,
       linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: AIC7xxx kernel problem with 2.4.2[234] kernels
In-Reply-To: <3942145408.1074564149@aslan.btc.adaptec.com>
Message-ID: <Pine.LNX.4.58.0401192259330.2123@home.osdl.org>
References: <400BDC85.8040907@wanadoo.es> <1074532919.1895.32.camel@mulgrave>
  <3747775408.1074537497@aslan.btc.adaptec.com> <1074559838.2078.1.camel@mulgrave>
 <3942145408.1074564149@aslan.btc.adaptec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Jan 2004, Justin T. Gibbs wrote:
> 
> Does the maintainer have the ability to veto changes that harm the
> code they maintain?

Nope. Nobody has that right.

Even _I_ don't veto changes that the right people push (my motto:
"everybody is wrong sometimes: when enough people complain, even I am
wrong"). 

In particular, maintainers of "conceptually higher" generally always have
priority. If Al Viro says a filesystem is doing something wrong from a VFS
standpoint, then that filesystem is broken - regardless of whether the
filesystem maintainer agrees or not. Because the VFS layer requirements 
trump any low-level filesystem issues.

But perhaps more importantly (and it's the reason even _I_ don't have the 
right, regardless of how high up in the maintainership chain I am), nobody 
has veto-power over anything. That's to keep people honest: nobody should 
_ever_ think that they are "in control", and that nobody else can replace 
them. 

In other words: maintainership is not ownership. It's a stewardship.

End result: maintainership is a nasty and mostly unthankful job. It
doesn't really give many privileges, and most of what it does is just have
people complain to you about bugs. The satisfaction is there, of course, 
but 

And finally: maintainership is largely about working with people.  
There's some code in there too, but people tend to be more important.

		Linus
