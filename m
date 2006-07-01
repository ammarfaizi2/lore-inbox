Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWGASLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWGASLL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 14:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWGASLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 14:11:11 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:26766 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750706AbWGASLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 14:11:09 -0400
Subject: Re: Eeek! page_mapcount(page) went negative! (-1)
From: Lee Revell <rlrevell@joe-job.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Daniel Drake <dsd@gentoo.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1151775918.3195.52.camel@laptopd505.fenrus.org>
References: <44A6AB99.8060407@gentoo.org>
	 <1151773620.3195.39.camel@laptopd505.fenrus.org>
	 <1151775860.12026.7.camel@mindpipe>
	 <1151775918.3195.52.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 14:11:24 -0400
Message-Id: <1151777485.12026.16.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-01 at 19:45 +0200, Arjan van de Ven wrote:
> On Sat, 2006-07-01 at 13:44 -0400, Lee Revell wrote:
> > On Sat, 2006-07-01 at 19:07 +0200, Arjan van de Ven wrote:
> > > On Sat, 2006-07-01 at 18:06 +0100, Daniel Drake wrote:
> > > > A user at http://bugs.gentoo.org/138366 reported a one-off crash on x86 
> > > > with 2.6.16.19. Here's hoping it might be useful to somebody:
> > > 
> > > does this happen too when the user stops using the binary nvidia driver?
> > > 
> > 
> > Shouldn't all BUGs include the state of the tainted flags?
> 
> unless the reporter edits those away ;)
> (same for the module list)
> 

Wow.  It boggles my mind that people try to get away with this.

Lee

