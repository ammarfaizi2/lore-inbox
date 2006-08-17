Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWHQLtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWHQLtH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 07:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWHQLtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 07:49:06 -0400
Received: from ns.suse.de ([195.135.220.2]:38114 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964825AbWHQLtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 07:49:05 -0400
From: Neil Brown <neilb@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 17 Aug 2006 21:48:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17636.22442.685045.874750@cse.unsw.edu.au>
Cc: Patrick McFarland <diablod3@gmail.com>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Anonymous User <anonymouslinuxuser@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL Violation?
In-Reply-To: message from Alan Cox on Thursday August 17
References: <40d80630608162248y498cb970r97a14c582fd663e1@mail.gmail.com>
	<200608170242.40969.diablod3@gmail.com>
	<44E429B3.7030607@s5r6.in-berlin.de>
	<200608170536.44733.diablod3@gmail.com>
	<1155813936.15195.57.camel@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday August 17, alan@lxorguk.ukuu.org.uk wrote:
> Ar Iau, 2006-08-17 am 05:36 -0400, ysgrifennodd Patrick McFarland:
> > > If a driver author doesn't want 
> > > to publish under the terms of GPL, an implementation in userspace may
> > > make it possible to avoid linking with GPL code.
> > 
> > But doesn't that force the GPL code to rely on closed source code, and not 
> > function properly without it? I remember a part in the GPL about not allowing 
> > that, but I can't seem to find it atm.
> 
> It shouldn't generally be a grey area but that is why the Linux kernel
> has always had this clarification in COPYING about the interpretation
> 
>   NOTE! This copyright does *not* cover user programs that use kernel
>  services by normal system calls - this is merely considered normal use
>  of the kernel, and does *not* fall under the heading of "derived work".
>  Also note that the GPL below is copyrighted by the Free Software
>  Foundation, but the instance of code that it refers to (the Linux
>  kernel) is copyrighted by me and others who actually wrote it.


Hmmm. I wonder what "normal" system calls are.  And how they contrast
to "abnormal" system calls, which presumably aren't covered by the
above note.
I wonder if reading and writing to files in /sys and /proc are
'normal' in this context or not.  Certainly I think that non-standard
ioctls could be considered to abnormal.

I guess that's one for the lawyers :-)

NeilBrown
