Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVAWW60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVAWW60 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 17:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVAWW6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 17:58:25 -0500
Received: from mail.suse.de ([195.135.220.2]:52680 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261372AbVAWW6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 17:58:18 -0500
From: Andreas Gruenbacher <agruen@suse.de>
To: tridge@osdl.org
Subject: Re: [ea-in-inode 0/5] Further fixes
Date: Sun, 23 Jan 2005 23:58:09 +0100
User-Agent: KMail/1.7.1
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Andreas Dilger <adilger@clusterfs.com>, Alex Tomas <alex@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <20050120020124.110155000@suse.de> <1106351172.19651.102.camel@winden.suse.de> <16884.8352.76012.779869@samba.org>
In-Reply-To: <16884.8352.76012.779869@samba.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501232358.09926.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sunday 23 January 2005 23:09, Andrew Tridgell wrote:
> Andreas,
>
>  > Tridge, can you beat the code some more?
>  >
>  > Andrew has the five fixes in 2.6.11-rc1-mm2.
>
> It seemed to pass dbench runs OK, but then I started simultaneously
> running dbench and nbench on two different disks (I have a new test
> machine with more disks available). I am getting failures like this:
>
> Jan 23 06:54:38 dev4-003 kernel: journal_bmap: journal block not found at
> offset 1036 on sdc1 Jan 23 06:54:38 dev4-003 kernel: Aborting journal on
> device sdc1.

Are you using data journaling on that filesystem? Does this test pass with the 
patches backed out? With an external journal?

Thanks,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH
