Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVAXL2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVAXL2m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 06:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVAXL2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 06:28:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:41648 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261493AbVAXL2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 06:28:40 -0500
From: Andrew Tridgell <tridge@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16884.56071.773949.280386@samba.org>
Date: Mon, 24 Jan 2005 22:24:55 +1100
To: Andreas Gruenbacher <agruen@suse.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Andreas Dilger <adilger@clusterfs.com>, Alex Tomas <alex@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ea-in-inode 0/5] Further fixes
In-Reply-To: <200501240032.17236.agruen@suse.de>
References: <20050120020124.110155000@suse.de>
	<16884.8352.76012.779869@samba.org>
	<200501232358.09926.agruen@suse.de>
	<200501240032.17236.agruen@suse.de>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas,

I'm starting to think the bug I saw is hardware error. I just got this
while trying to reproduce it tonight:

Jan 24 02:43:32 dev4-003 kernel: qlogicfc0 : abort failed
Jan 24 02:43:32 dev4-003 kernel: qlogicfc0 : firmware status is 4000 4
Jan 24 02:43:32 dev4-003 kernel: scsi: Device offlined - not ready after error recovery: host 3 
channel 0 id 1 lun 0

I'll see if I can get this confirmed tomorrow.

Cheers, Tridge
