Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAENsD>; Fri, 5 Jan 2001 08:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130339AbRAENrw>; Fri, 5 Jan 2001 08:47:52 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:56076 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129267AbRAENrl>; Fri, 5 Jan 2001 08:47:41 -0500
Date: Fri, 05 Jan 2001 08:47:34 -0500
From: Chris Mason <mason@suse.com>
To: Claas Langbehn <claas@bigfoot.com>
cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: reiserfs patch for 2.4.0-final
Message-ID: <502300000.978702454@tiny>
In-Reply-To: <20010105140408.A2812@villariba.2y.net>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, January 05, 2001 02:04:08 PM +0100 Claas Langbehn
<claas@bigfoot.com> wrote:

> On Thu, Jan 04, 2001 at 04:52:49PM -0500, Chris Mason wrote:
>> This patch is meant to be applied on top of the reiserfs
>> 3.6.23 patch to get everything working in the new prerelease
>> kernels.  The order is:
>> 
>> untar linux-2.4.0-prerelease.tar.bz2
>> apply linux-2.4.0-test12-reiserfs-3.6.23.gz
>> apply this patch
>> apply the fs/super.c patch to make sure fsync_dev is called
>> when unmounting /.  This was already sent to l-k, I'll send
>> to the reiserfs list as well.
> 
> Is this still correct for the final 2.4.0-kernel ?
> 
Yes

> Could someone create one single patch for the 2.4.0 ?
> 
I put all the code into CVS, and Yura is making the official patch now.

-chris





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
