Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbTIINnH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 09:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264114AbTIINnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 09:43:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:32396 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264097AbTIINnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 09:43:05 -0400
Date: Tue, 9 Sep 2003 15:09:02 +0200
From: Pavel Machek <pavel@suse.cz>
To: Hans Reiser <reiser@namesys.com>
Cc: Andreas Dilger <adilger@clusterfs.com>, Mike Fedyk <mfedyk@matchmail.com>,
       Andrew Morton <akpm@osdl.org>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: precise characterization of ext3 atomicity
Message-ID: <20030909130902.GE3944@openzaurus.ucw.cz>
References: <3F574A49.7040900@namesys.com> <20030904085537.78c251b3.akpm@osdl.org> <3F576176.3010202@namesys.com> <20030904091256.1dca14a5.akpm@osdl.org> <3F57676E.7010804@namesys.com> <20030904181540.GC13676@matchmail.com> <3F578656.60005@namesys.com> <20030904132804.D15623@schatzie.adilger.int> <3F57AF79.1040702@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F57AF79.1040702@namesys.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Yup.  That's why we confine it to a (finite #defined number) set of 
> operations within one sys_reiser4 call.  At some point we will allow 
> trusted user space processes to span multiple system calls (mail 
> server applicances, database appliances, etc., might find this 
> useful).  You might consider supporting sys_reiser4 at some point.


Well, if you want that API to be widely usable, you should invent
better name than sys_reiser4 :-).
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

