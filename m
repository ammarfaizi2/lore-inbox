Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422771AbWJaIfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422771AbWJaIfp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 03:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030575AbWJaIfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 03:35:45 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:46799 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1030467AbWJaIfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 03:35:45 -0500
Date: Tue, 31 Oct 2006 09:32:03 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Dave Kleikamp <shaggy@austin.ibm.com>
cc: Daniel Drake <ddrake@brontes3d.com>, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jfs: Add splice support
In-Reply-To: <1162227415.24229.2.camel@kleikamp.austin.ibm.com>
Message-ID: <Pine.LNX.4.61.0610310931020.23540@yvahk01.tjqt.qr>
References: <20061030163148.2412D7B40A0@zog.reactivated.net>
 <1162227415.24229.2.camel@kleikamp.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> This allows the splice() and tee() syscalls to be used with JFS.
>
>Gosh, that was easy.  Why couldn't I do that?  :-)

You could add it to all the other filesystems that lack it. (Cautionary 
question: Does that work at an instant like it did with jfs?)

Seems like only ext[234] gfs2 reiserfs and xfs have splice_read 
currently.


	-`J'
-- 
