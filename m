Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261738AbTCQPXW>; Mon, 17 Mar 2003 10:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261740AbTCQPXW>; Mon, 17 Mar 2003 10:23:22 -0500
Received: from comtv.ru ([217.10.32.4]:16854 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S261738AbTCQPXV>;
	Mon, 17 Mar 2003 10:23:21 -0500
X-Comment-To: Matthew Wilcox
To: Matthew Wilcox <willy@debian.org>
Cc: Andreas Dilger <adilger@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
Subject: Re: [Ext2-devel] [PATCH] distributed counters for ext2 to avoid group scaning
References: <m3el5773to.fsf@lexa.home.net>
	<20030316104447.D12806@schatzie.adilger.int>
	<m3bs0bugca.fsf@lexa.home.net>
	<20030317151108.GC28607@parcelfarce.linux.theplanet.co.uk>
	<m3ptoqjagt.fsf@lexa.home.net>
	<20030317152719.GD28607@parcelfarce.linux.theplanet.co.uk>
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 17 Mar 2003 18:25:50 +0300
In-Reply-To: <20030317152719.GD28607@parcelfarce.linux.theplanet.co.uk>
Message-ID: <m37kayj9q9.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Matthew Wilcox (MW) writes:

 MW> Gah.  That's your fault.  Use diff -p in future; I saw:

thanks for advice. I will.

 MW> which makes it look like the dcounters are added to ext2_bg_info.
 MW> diff -p would have put the name of the struct after the @@ line.
 MW> Not to mention you didn't follow the `s_' prefix style used
 MW> everywhere else in that struct.

this makes sense too.

 MW> Anyway, I think dcounters should probably be allocated from
 MW> kmalloc_percpu() rather than as part of the dcounter struct.

take a look.


