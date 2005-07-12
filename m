Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262324AbVGLTpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbVGLTpN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 15:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbVGLTnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 15:43:43 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:31556 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S262349AbVGLTmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 15:42:21 -0400
Date: Tue, 12 Jul 2005 15:42:20 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: [PATCH/URL] reiserfs: reformat code with Lindent
Message-ID: <20050712194220.GA28973@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.151-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 The ReiserFS code is a mix of a number of different coding styles, sometimes
 different even from line-to-line. Since the code has been relatively stable
 for quite some time and there are few outstanding patches to be applied, it
 is time to reformat the code to conform to the Linux style standard outlined
 in Documentation/CodingStyle.

 This patch contains the result of running scripts/Lindent against
 fs/reiserfs/*.c and include/linux/reiserfs_*.h. There are places where the
 code can be made to look better, but I'd rather keep those patches separate
 so that there isn't a subtle by-hand hand accident in the middle of a huge
 patch. To be clear: This patch is reformatting *only*.

 A number of patches may follow that continue to make the code more consistent
 with the Linux coding style.

 Hans wasn't particularly enthusiastic about these patches, but said he
 wouldn't really oppose them either.

 Due to the size of this patch (1.5M), I've posted it at:
 ftp://ftp.suse.com/pub/people/jeffm/reiserfs/kernel-v2.6/cleanups/2.6.13-rc2/01-reiserfs-lindent.diff

 -Jeff

-- 
Jeff Mahoney
SuSE Labs
