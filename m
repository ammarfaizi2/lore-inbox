Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288012AbSBZO46>; Tue, 26 Feb 2002 09:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287874AbSBZO4s>; Tue, 26 Feb 2002 09:56:48 -0500
Received: from 216-42-72-168.ppp.netsville.net ([216.42.72.168]:48308 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S284933AbSBZO4l>; Tue, 26 Feb 2002 09:56:41 -0500
Date: Tue, 26 Feb 2002 09:55:55 -0500
From: Chris Mason <mason@suse.com>
To: Brian Ristuccia <bristucc@sw.starentnetworks.com>,
        linux-kernel@vger.kernel.org
Subject: Re: kernel nfsd consuming 100% CPU on 2.4.17 and 2.4.18 with
 reiserfs?
Message-ID: <2305220000.1014735355@tiny>
In-Reply-To: <3C7B9212.5050400@sw.starentnetworks.com>
In-Reply-To: <3C7B9212.5050400@sw.starentnetworks.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, February 26, 2002 08:48:02 AM -0500 Brian Ristuccia
<bristucc@sw.starentnetworks.com> wrote:

> It seems that kernel nfsd consumes an inordinate amount of CPU time
> during writes on this machine. With a few hundred kb/sec being written
> over NFSv3 from a 2.2.17 client, all of the nfsd threads each consume as
> much of the available CPU time as possible. On a similarly configured
> machine with ext3 instead of reiserfs, nfsd consumes much less CPU time.
> 
> Is there a known issue with NFSv3 performance and reiserfs?

No, it is not a known issue.  Does it only happen with a 2.2.17 client, or
can you reproduce with any kernel version on the client?

-chris

