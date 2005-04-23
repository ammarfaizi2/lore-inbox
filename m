Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVDWLWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVDWLWY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 07:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVDWLWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 07:22:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30119 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261542AbVDWLWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 07:22:20 -0400
Date: Sat, 23 Apr 2005 13:19:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Petr Baudis <pasky@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050423111900.GA2226@openzaurus.ucw.cz>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <20050421112022.GB2160@elf.ucw.cz> <20050421120327.GA13834@elf.ucw.cz> <20050421162220.GD30991@pasky.ji.cz> <20050421232201.GD31207@elf.ucw.cz> <20050422002150.GY7443@pasky.ji.cz> <20050422231839.GC1789@elf.ucw.cz> <Pine.LNX.4.58.0504221718410.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504221718410.2344@ppc970.osdl.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On Sat, 23 Apr 2005, Pavel Machek wrote:
> > 
> > Unfortunately first merge will make it practically unusable :-(. 
> 
> No, quite the reverse. If I merge from you, and you use my commit ID as 
> the "base" point, it will work again.

I meant "every time I merge from you, new commit with message 'merge from linus' and
big ugly diff is attached.

> But yes, if you actually send the result as _patches_ to me, then the 
> commit objects I create will be totally separate from the commit objects 
> you had in your tree, and "git-export" will continue to export your old 
> stale entries since they won't show up as already being in my tree.
> 
> The point being, that there is a big difference between a proper merge 
> (with history etc merged) and just sending me the patches in your tree.

Could we add some kind off "This-changeset-obsoletes: <sha1>" header?
That would  allow me to send patches by hand and still make the SCM do the
right thing during merge.

Alternatively I should just get public rsync-able space somewhere...
Would kernel.org be willing to add people/pavel?

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

