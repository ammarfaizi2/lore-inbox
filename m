Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbWEOLVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWEOLVL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 07:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWEOLVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 07:21:11 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:23301 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S964889AbWEOLVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 07:21:10 -0400
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: Re: nfsservctl() compatibility broken on AMD64?
In-Reply-To: <Pine.SOC.4.61.0605151220130.27015@math.ut.ee>
User-Agent: tin/1.8.2-20060425 ("Shillay") (UNIX) (Linux/2.6.17-rc4-g9be2f7c3-dirty (i686))
Message-Id: <20060515112108.465A8140A1@rhn.tartu-labor>
Date: Mon, 15 May 2006 14:21:08 +0300 (EEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MR> I'm trying to use the latest amd64 kernel (2.6.17-rc3 compiled last 
MR> week) with Debian Sarge 32-bit userland (is it reasonable to expect it 
MR> to work?).
MR> 
MR> There's a problem with exportfs. I can export to IP ranges OK but I can 
MR> not export to single hosts - nfsservctl() returns EFAULT.

Sorry, probably a false alarm - I got it it work with loading nfsd
module and mounting /proc/fs/nfsd by hand, so it's probably something
initscripts related.

-- 
Meelis Roos
