Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263393AbUJ2PiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263393AbUJ2PiM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 11:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263395AbUJ2PhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 11:37:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:49841 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S263344AbUJ2PQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 11:16:16 -0400
Subject: Re: [patch] 2.6.10-rc1: SCSI aacraid warning
From: Mark Haverkamp <markh@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-scsi <linux-scsi@vger.kernel.org>
In-Reply-To: <1099061134.13961.2.camel@markh1.pdx.osdl.net>
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
	 <20041029143712.GM6677@stusta.de>
	 <1099061134.13961.2.camel@markh1.pdx.osdl.net>
Content-Type: text/plain
Date: Fri, 29 Oct 2004 08:13:02 -0700
Message-Id: <1099062782.13961.5.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 07:45 -0700, Mark Haverkamp wrote:
> On Fri, 2004-10-29 at 16:37 +0200, Adrian Bunk wrote:
> > On Fri, Oct 22, 2004 at 03:05:13PM -0700, Linus Torvalds wrote:
> > >...
> > > Summary of changes from v2.6.9 to v2.6.10-rc1
> > > ============================================
> > >...
> > > Mark Haverkamp:
> > >...
> > >   o aacraid: dynamic dev update
> > >...
> > 
> > 
> > This causes the following warning with a recent gcc:
> > 
[ ... ]
> Sorry about that, I have it fixed in my working version.  I must have
> forgotten to add it to the patch.


Actually looking back,  I did fix this in a recent patch that 
I sent to James titled

"[PATCH] 2.6.9 aacraid: Support ROMB RAID/SCSI mode" on October 21.

Mark.


-- 
Mark Haverkamp <markh@osdl.org>

