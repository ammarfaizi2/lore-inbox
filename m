Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965232AbWFIUq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965232AbWFIUq7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965219AbWFIUq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:46:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38324 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965200AbWFIUq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:46:58 -0400
Date: Fri, 9 Jun 2006 13:46:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Jeff Garzik <jeff@garzik.org>, Andreas Dilger <adilger@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mingming Cao <cmm@us.ibm.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
In-Reply-To: <1149885135.5776.100.camel@sisko.sctweedie.blueyonder.co.uk>
Message-ID: <Pine.LNX.4.64.0606091344290.5498@g5.osdl.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> 
 <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> 
 <44898EE3.6080903@garzik.org> <1149885135.5776.100.camel@sisko.sctweedie.blueyonder.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Jun 2006, Stephen C. Tweedie wrote:
> 
> When is the Linux syscall interface enough?  When should we just bump it
> and cut out all the compatibility interfaces?
> 
> No, we don't; we let people configure certain obsolete bits out (a.out
> support etc), but we keep it in the tree despite the indirection cost to
> maintain multiple interfaces etc.

Right. WE ADD NEW SYSTEM CALLS. WE DO NOT EXTEND THE OLD ONES IN WAYS THAT 
MIGHT BREAK OLD USERS.

Your point was exactly what?

Btw, where did that 2TB limit number come from? Afaik, it should be 16TB 
for a 4kB filesystem, no?

		Linus
