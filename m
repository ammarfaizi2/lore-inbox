Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWBMRJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWBMRJs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 12:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWBMRJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 12:09:47 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16901 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932242AbWBMRJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 12:09:47 -0500
Date: Mon, 13 Feb 2006 18:09:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mauro Tassinari <mtassinari@cmanet.it>, Dave Jones <davej@redhat.com>,
       Meelis Roos <mroos@linux.ee>, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz,
       Claudio Martins <ctpm@rnl.ist.utl.pt>,
       Mark Fasheh <mark.fasheh@oracle.com>, kurt.hackel@oracle.com,
       ocfs2-devel@oss.oracle.com
Subject: 2.6.16-rc3: more regressions
Message-ID: <20060213170945.GB6137@stusta.de>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have some regressions [1] on my list that weren't metioned by Andrew:


Subject    : Xorg freezes 2.6.16-rc1
References : http://lkml.org/lkml/2006/1/26/97
Submitter  : Mauro Tassinari <mtassinari@cmanet.it>
Status     : unknown

Subject    : 2.6.16rc1-git4 slab corruption
References : http://lkml.org/lkml/2006/1/31/164
Submitter  : Dave Jones <davej@redhat.com>
Status     : unknown

Subject    : psmouse starts losing sync in 2.6.16-rc2
References : http://lkml.org/lkml/2006/2/5/50
Submitter  : Meelis Roos <mroos@linux.ee>
Status     : unknown

Subject    : OCFS2 Filesystem inconsistency across nodes
References : http://lkml.org/lkml/2006/2/10/14
Submitter  : Claudio Martins <ctpm@rnl.ist.utl.pt>
Handled-By : Mark Fasheh <mark.fasheh@oracle.com>
Status     : unknown



cu
Adrian

[1] "regression" defined as "bug was not present in 2.6.15"

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


