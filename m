Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263005AbVCDTGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263005AbVCDTGI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 14:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262997AbVCDTBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 14:01:50 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:5547
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262998AbVCDS7R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 13:59:17 -0500
Subject: Re: RFD: Kernel release numbering
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0503040956420.25732@ppc970.osdl.org>
References: <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	 <422751C1.7030607@pobox.com> <20050303181122.GB12103@kroah.com>
	 <20050303151752.00527ae7.akpm@osdl.org>
	 <20050303234523.GS8880@opteron.random>
	 <20050303160330.5db86db7.akpm@osdl.org>
	 <20050304025746.GD26085@tolot.miese-zwerge.org>
	 <20050303213005.59a30ae6.akpm@osdl.org>
	 <1109924470.4032.105.camel@tglx.tec.linutronix.de>
	 <20050304005450.05a2bd0c.akpm@osdl.org> <20050304091612.GG14764@suse.de>
	 <20050304012154.619948d7.akpm@osdl.org>
	 <Pine.LNX.4.58.0503040956420.25732@ppc970.osdl.org>
Content-Type: text/plain
Date: Fri, 04 Mar 2005 19:59:14 +0100
Message-Id: <1109962755.4032.187.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-04 at 09:57 -0800, Linus Torvalds wrote:
> I've long since decided that there's no point to making "-pre". What's the 
> difference between a "-pre" and a daily -bk snapshot? Really?

-preX are milestones mainly for developers

When -preX is converted to -rc1 then it defines feature freeze and the
testing / polishing steps to the final release take place, with "serious
bugfixes only" policy.

I know you think the -rc polishing is boring, so why don't you give it
to somebody else ? 

In fact the 2.6.x.y tree is a substitution for this. So the official
2.6.X release will be considered a real release candidate within no
time.

If this is your intention, then please state it loud and clearly and use
generally known and understandable naming conventions for it.

> So when I do a release, it _is_ an -rc. The fact that people have trouble 
> understanding this is not _my_ fault.

If you are referring to rc == "ridiculous count", I agree that it is not
your fault. Its not necessary to understand that.

If you refer to rc == "release candidate", please start to act in a way
which people _can_ actually understand without reading LKML and finding
the proclamation mail, in which you declare that ridiculous count should
now be considered as a release candidate.

There is no way to change common practice by proclamation. 

tglx


