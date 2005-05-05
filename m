Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbVEEUOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVEEUOK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 16:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVEETeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 15:34:16 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:26522 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261468AbVEESvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 14:51:17 -0400
Subject: Re: [git pull] jfs update
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0505051119440.2328@ppc970.osdl.org>
References: <20050504204744.DA0A0849AD@kleikamp.dyn.webahead.ibm.com>
	 <Pine.LNX.4.58.0505041437060.2328@ppc970.osdl.org>
	 <427A630E.5000008@pobox.com>
	 <Pine.LNX.4.58.0505051119440.2328@ppc970.osdl.org>
Content-Type: text/plain
Date: Thu, 05 May 2005 13:51:07 -0500
Message-Id: <1115319068.8473.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-05 at 11:22 -0700, Linus Torvalds wrote:
> 
> On Thu, 5 May 2005, Jeff Garzik wrote:
> > 
> > FWIW I'm definitely interested in some sort of pull mechanism where I 
> > can say "pull from foo://.../libata-2.6.git/HEAD-for-linus" also.
> 
> I already changed my scripts to be able to do that. They default to HEAD, 
> but if you tell them something else, they'll get that instead.
> 
> So I'd do a
> 
> 	git-pull-script foo://.../libata-2.6.git/ HEAD-for-linus
> 
> except right now my pull script only works with rsync or ssh, not http. 
> I'll fix that up asap.
> 
> 		Linus
Andrew,
You can pull:

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git/HEAD-for-mm

whenever you do an -mm build.  If your scripts have a problem with that,
you might try

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git#for-mm

Let me know which you prefer.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

