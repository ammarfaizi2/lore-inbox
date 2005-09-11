Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbVIKVJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbVIKVJh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 17:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbVIKVJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 17:09:37 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:31410 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750867AbVIKVJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 17:09:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Peter Osterlund <petero2@telia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: What's up with the GIT archive on www.kernel.org?
X-Message-Flag: Warning: May contain useful information
References: <m3mzmjvbh7.fsf@telia.com>
	<Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
	<20050911185711.GA22556@mars.ravnborg.org>
	<Pine.LNX.4.58.0509111157360.3242@g5.osdl.org>
	<20050911194630.GB22951@mars.ravnborg.org>
	<Pine.LNX.4.58.0509111251150.3242@g5.osdl.org>
From: Roland Dreier <rolandd@cisco.com>
Date: Sun, 11 Sep 2005 14:09:30 -0700
In-Reply-To: <Pine.LNX.4.58.0509111251150.3242@g5.osdl.org> (Linus
 Torvalds's message of "Sun, 11 Sep 2005 12:56:12 -0700 (PDT)")
Message-ID: <52irx7cnw5.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 11 Sep 2005 21:09:31.0534 (UTC) FILETIME=[1A6AF2E0:01C5B715]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Linus> You can try removing all the packs in your
    Linus> .git/objects/packs directory. Everything _should_ still
    Linus> work fine.

Does "everything" include someone doing

    git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/roland/whatever.git

How about http:// instead of rsync://?

In other words, is the git network transport smart enough to handle
the alternates path?

Or is the idea that everyone will clone your tree and then pull extra
stuff from other trees?

 - R.
