Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265740AbUFXVtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265740AbUFXVtP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265745AbUFXVsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:48:20 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:63687 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S265740AbUFXVrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:47:04 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Joshua Kwan <jkwan@rackable.com>
Date: Fri, 25 Jun 2004 07:46:48 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16603.19400.833911.26478@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [HELP] Tracking down a MD bug
In-Reply-To: message from Joshua Kwan on Thursday June 24
References: <pan.2004.06.24.17.24.17.353731@rackable.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday June 24, jkwan@rackable.com wrote:
> Hello,
> 
> I've been running benchmarks on a ~2TB software RAID array of varying
> configurations using SuSE Linux 9.1's kernel 2.6.4-52-smp. I noticed that
> while resyncing a newly created RAID 5 array the kernel would just hang
> a few seconds after starting.
> 
> I compiled 2.6.7-mm1 just now and the RAID array is busy resyncing, and
> still alive, right now.
> 
> Are there any MD code changes that could have caused this so I can point
> SuSE somewhere? (Well, then again, many SuSE folks are on this list
> anyway...)

This is definitely a bug in the Suse 2.6.4-52 kernels, and I'm pretty
sure they have fixed it.

NeilBrown

> 
> This is on the x86_64 architecture, highmem + SMP + SATA RAID adapter
> (although I'm not using it in hardware mode.) I'll provide config/dmesg
> from the old kernel on request.
> 
> Thanks,
> 
> -- 
> Joshua Kwan
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
