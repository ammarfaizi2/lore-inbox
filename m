Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751936AbWJWMbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbWJWMbe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 08:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937AbWJWMbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 08:31:34 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13992 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751913AbWJWMbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 08:31:33 -0400
Date: Mon, 23 Oct 2006 10:17:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Constantine Gavrilov <constg@qlusters.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Would SSI clustering extensions be of interest to kernel community?
Message-ID: <20061023081758.GA11620@elf.ucw.cz>
References: <45337FE3.8020201@qlusters.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45337FE3.8020201@qlusters.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have implemented SSI (single system image) clustering extensions to 
> Linux kernel in the form of a loadable module.
> 
> It roughly mimics OpenMosix model of deputy/remote split (migrated 
> processes leave a stub on the node where they were born and depend on 
> the "home" node for IO).
> 
> The implementation shares no code with Mosix/Open Mosix (was written 
> from scratch), is much smaller, and is easily portable to multiple 
> architectures.
> 
> We are considering publication of this code and forming an open source 
> project around it.
> 
> I have two questions to the community:
> 
> 1) Is community interested in using this code? Do users require SSI 
> product in the era when everybody is talking about partitioning of 
> machines and not clustering?

Yes... Remember that some people run hypervisors to enable process
migration.

> 2) Are kernel maintainers interested in clustering extensions to Linux 
> kernel? Do they see any value in them? (Our code does not require kernel 
> changes, but we are willing to submit it for inclusion if there is 
> interest.)

I'd say so.
									Pavel


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
