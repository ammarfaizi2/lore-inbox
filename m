Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267651AbRG0Pe2>; Fri, 27 Jul 2001 11:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268865AbRG0PeS>; Fri, 27 Jul 2001 11:34:18 -0400
Received: from [194.213.32.142] ([194.213.32.142]:5892 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S267651AbRG0PeI>;
	Fri, 27 Jul 2001 11:34:08 -0400
Date: Mon, 23 Jul 2001 13:38:40 +0000
From: Pavel Machek <pavel@suse.cz>
To: Detlev Offenbach <detlev@offenbach.fs.uunet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MO-Drive under 2.4.7 usinf vfat
Message-ID: <20010723133840.A39@toy.ucw.cz>
In-Reply-To: <01072115265800.02284@majestix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <01072115265800.02284@majestix>; from detlev@offenbach.fs.uunet.de on Sat, Jul 21, 2001 at 03:26:58PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi!

> I have just tested the new 2.4.7 kernel to see, whether it now works with a 
> MO-Drive using the vfat filesystem. Unfortunately it still doesn't. Mounting 
> a disk and writing to it is ok. However, when I try to read a file off the 
> disk, the program crashes with a Segmentation fault and I get a oops in the 
> messages file (see attachment). I tried ksymoops on this file, but either I 
> did something wrong or it couldn't analyse it.
> 
> I hope, this issue will be fixed soon cause I would like to switch over to 
> the 2.4 kernel series without scratching my set of MO-disks.

Try -o loop

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

