Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267706AbRGUQSI>; Sat, 21 Jul 2001 12:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267707AbRGUQR6>; Sat, 21 Jul 2001 12:17:58 -0400
Received: from ohiper1-58.apex.net ([209.250.47.73]:29958 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S267706AbRGUQRr>; Sat, 21 Jul 2001 12:17:47 -0400
Date: Sat, 21 Jul 2001 11:17:33 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Detlev Offenbach <detlev@offenbach.fs.uunet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MO-Drive under 2.4.7 usinf vfat
Message-ID: <20010721111732.A9618@hapablap.dyn.dhs.org>
In-Reply-To: <01072115265800.02284@majestix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01072115265800.02284@majestix>; from detlev@offenbach.fs.uunet.de on Sat, Jul 21, 2001 at 03:26:58PM +0200
X-Uptime: 11:05am  up 14:47,  0 users,  load average: 1.00, 1.00, 1.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, Jul 21, 2001 at 03:26:58PM +0200, Detlev Offenbach wrote:
> Hi all,
> 
> I have just tested the new 2.4.7 kernel to see, whether it now works with a 
> MO-Drive using the vfat filesystem. Unfortunately it still doesn't. Mounting 
> a disk and writing to it is ok. However, when I try to read a file off the 
> disk, the program crashes with a Segmentation fault and I get a oops in the 
> messages file (see attachment). I tried ksymoops on this file, but either I 
> did something wrong or it couldn't analyse it.
> 
> I hope, this issue will be fixed soon cause I would like to switch over to 
> the 2.4 kernel series without scratching my set of MO-disks.

You might try the -ac series.  I recall 2048 byte blocks being
implemented in its version of vfat (which is likely the problem you're
hitting).  Perhaps that particular patch hasn't made it to Linus' tree,
yet.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
