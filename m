Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277229AbRJINzz>; Tue, 9 Oct 2001 09:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277231AbRJINzh>; Tue, 9 Oct 2001 09:55:37 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:27529
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S277229AbRJINzQ>; Tue, 9 Oct 2001 09:55:16 -0400
Date: Tue, 09 Oct 2001 09:55:37 -0400
From: Chris Mason <mason@suse.com>
To: rwhron@earthlink.net, linux-kernel@vger.kernel.org,
        ltp-list@lists.sourceforge.net
Subject: Re: [LTP] VFS: brelse: started after 2.4.10-ac7 
Message-ID: <307890000.1002635737@tiny>
In-Reply-To: <20011009094707.B4951@earthlink.net>
In-Reply-To: <20011009094707.B4951@earthlink.net>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, October 09, 2001 09:47:07 AM -0400 rwhron@earthlink.net wrote:

> 
> About 2 minutes into "runalltests.sh" on ltp, ac kernels after 2.4.10-ac7
> give a message like:
> 
> Oct  9 01:55:09 rushmore kernel: VFS: brelse: Trying to free free buffer
> Oct  9 01:55:09 rushmore kernel: VFS: brelse: Trying to free free buffer

I might have missed something in the details, but you seem to be implying
this only happens on top of reiserfs.  It does look like one of the
reiserfs patches in -ac triggers this, they are looking for the cause.

-chris

