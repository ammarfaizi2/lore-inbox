Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272043AbTHDRTD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 13:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272044AbTHDRTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 13:19:03 -0400
Received: from zork.zork.net ([64.81.246.102]:57534 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S272043AbTHDRTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 13:19:01 -0400
To: Hans Reiser <reiser@namesys.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
       Jesse Pollard <jesse@cats-chateau.net>, aebr@win.tue.nl,
       linux-kernel@vger.kernel.org, god@namesys.com, Vitaly@Namesys.COM
Subject: Re: FS: hardlinks on directories
References: <20030804141548.5060b9db.skraw@ithnet.com>
	<20030804134415.GA4454@win.tue.nl>
	<20030804155604.2cdb96e7.skraw@ithnet.com>
	<03080409334500.03650@tabby>
	<20030804170506.11426617.skraw@ithnet.com>
	<3F2E9145.5090407@namesys.com>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Hans Reiser <reiser@namesys.com>, Stephan von Krawczynski
 <skraw@ithnet.com>, Jesse Pollard <jesse@cats-chateau.net>, 
 aebr@win.tue.nl, linux-kernel@vger.kernel.org,  god@namesys.com, 
 Vitaly@Namesys.COM
Date: Mon, 04 Aug 2003 18:18:30 +0100
In-Reply-To: <3F2E9145.5090407@namesys.com> (Hans Reiser's message of "Mon,
 04 Aug 2003 21:00:53 +0400")
Message-ID: <6uadape3yx.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> writes:

> If you want hard linked directories, send us a patch for v4.  Should
> be VERY easy to write.   If there is some reason it is not simple, let
> me know.  Discuss it with Vitaly though, it might affect fsck.

The commentary above fs/namei.c:vfs_rename_dir indicates that the
locking is already pretty tricky, and it seems to assume that a
directory can have only one parent.

