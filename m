Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWIDMEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWIDMEo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbWIDMEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:04:43 -0400
Received: from ns1.suse.de ([195.135.220.2]:3803 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964843AbWIDMEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:04:42 -0400
From: Neil Brown <neilb@suse.de>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Mon, 4 Sep 2006 22:04:30 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17660.5710.887383.554921@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
       apiszcz@lucidpixels.com
Subject: Re: [NFS] 2.6.17.6 New(?) NFS Kernel Bug (OOPS) When vi
	/over/nfs/file.txt
In-Reply-To: message from Justin Piszcz on Thursday August 31
References: <Pine.LNX.4.64.0608310708050.2348@p34.internal.lan>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday August 31, jpiszcz@lucidpixels.com wrote:
> Short description: I have a text file I was editing over NFS, around 4 to 
> 5 kilobytes.  It was during this time this occured:
> 
> Note, this is the first time I have ever seen this bug.
> My .config is attached.  After a reboot, I ran the same vi command, no 
> issues, so I could easily reproduce the problem.
> 
> Could anyone offer any insight to exactly what it was that caused this 
> bug?

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=2f34931fdc78b4895553aaa33748939cc7697c99

This is fixed in a 2.6.17.11 and possibly earlier stable releases.

NeilBrown

-- 
VGER BF report: H 0.058544
