Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWFMMsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWFMMsT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 08:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWFMMsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 08:48:03 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2065 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1750728AbWFMMrv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 08:47:51 -0400
Date: Mon, 12 Jun 2006 22:06:05 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Garzik <jeff@garzik.org>
Cc: Matthew Frost <artusemrys@sbcglobal.net>, Alex Tomas <alex@clusterfs.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060612220605.GD4950@ucw.cz>
References: <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <448997FA.50109@garzik.org> <m3irnacohp.fsf@bzzz.home.net> <44899A1C.7000207@garzik.org> <m3ac8mcnye.fsf@bzzz.home.net> <4489B83E.9090104@sbcglobal.net> <20060609181426.GC5964@schatzie.adilger.int> <4489C34B.1080806@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4489C34B.1080806@garzik.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >If ext2 and ext3 didn't support > 2GB files (which was 
> >a filesystem
> >feature added in exactly the same way as extents are 
> >today, and nobody
> >bitched about it then) then they would be relegated to 
> >the same status
> >as minix and xiafs and all the other filesystems that 
> >are stuck in the
> >"we can't change" or "we aren't supported" camps.
> 
> PRECISELY.  So you should stop modifying a filesystem 
> whose design is admittedly _not_ modern!
> 
> ext3 is already essentially xiafs-on-life-support, when 
> you consider today's large storage systems and today's 
> filesystem technology. 

Please don't. AFAIK, ext2/3 is only filesystem with working fsck
(because that fsck was actually needed in the old days). Starting from
xfs/jfs/reiser/??? means we no longer have working fsck...

-- 
Thanks for all the (sleeping) penguins.
