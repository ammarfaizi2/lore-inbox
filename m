Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbUCLFsc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 00:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbUCLFsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 00:48:32 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:18869 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261966AbUCLFsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 00:48:31 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 12 Mar 2004 16:48:24 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16465.20264.563965.518274@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
In-Reply-To: message from Andrew Morton on Thursday March 11
References: <20040310233140.3ce99610.akpm@osdl.org>
	<16465.3163.999977.302378@notabene.cse.unsw.edu.au>
	<20040311172244.3ae0587f.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday March 11, akpm@osdl.org wrote:
> 
> Tried adding earlyprintk=vga?
> 
> If that works, judicious addition of printks will narrow it down.

It doesn't.

I've tried compiling with SMP - no go.
I've tried with gcc-2.95 (instead of 3.3.2).  Still no go.

I thought I might try selectively removing patches, but it isn't clear
what order the borken-out patches were applied it.
If you have an ordered list, I can try a binary search.
Or if you can suggest some patches that I can try backing out....

NeilBrown
