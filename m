Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275398AbRJNOxP>; Sun, 14 Oct 2001 10:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275301AbRJNOwz>; Sun, 14 Oct 2001 10:52:55 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:24521
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S275448AbRJNOwo>; Sun, 14 Oct 2001 10:52:44 -0400
Date: Sun, 14 Oct 2001 10:52:54 -0400
From: Chris Mason <mason@suse.com>
To: Jens Benecke <jens@jensbenecke.de>, linux-kernel@vger.kernel.org,
        Reiserfs mail-list <Reiserfs-List@namesys.com>
Subject: Re: [reiserfs-list] Re: ReiserFS data corruption in very simple
 configuration
Message-ID: <2143070000.1003071174@tiny>
In-Reply-To: <20010924112510.F15955@jensbenecke.de>
In-Reply-To: <200109221000.GAA11263@out-of-band.media.mit.edu>
 <15276.34915.301069.643178@beta.reiserfs.com>
 <20010924112510.F15955@jensbenecke.de>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, September 24, 2001 11:25:10 AM +0200 Jens Benecke
<jens@jensbenecke.de> wrote:

> one question:
> 
> When I was using ext2 I always mounted the /usr partition read-only, so
> that a fsck weren't necessary at boot - and the files were all guaranteed
> to be OK to bring the system up at least.
> 
> Does this (mount -o ro) make sense with ReiserFS as well? What I mean is,
> is there a chance of a file getting corrupted that was only *read* (not
> *written*) at or before a power outage?

Yes, after the mount is finished, reiserfs won't change the files on a
readonly mount.

-chris

