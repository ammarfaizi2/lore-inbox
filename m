Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbUCPKxv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 05:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263450AbUCPKxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 05:53:51 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:45549 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262697AbUCPKxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 05:53:50 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 16 Mar 2004 21:53:38 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16470.56498.623319.681892@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.5-rc1-mm1 - looks better
In-Reply-To: message from Andrew Morton on Tuesday March 16
References: <20040316015338.39e2c48e.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday March 16, akpm@osdl.org wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc1/2.6.5-rc1-mm1/
> 
> 
> - A small update, mainly trying to get things stabilised after some
>   problems with the disk unplugging and early x86 boot code.  We may still
>   have a problem with the latter.

I tried on my server that wasn't booting 2.6.4-mm1.

It is much happier.

I noticed that rc1-mm1 causes 4KSTACKS to be forced =y, where as in
2.6.4-mm1, it defaulted to =n.
So I retested 2.6.4-mm1 with 4KSTACKS=y and it still fails.

So: 2.6.5-rc1-mm1 seems to have fixed the problem I was having.

Thanks,
NeilBrown

