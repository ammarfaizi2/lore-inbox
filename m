Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266922AbRGHQ67>; Sun, 8 Jul 2001 12:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266924AbRGHQ6t>; Sun, 8 Jul 2001 12:58:49 -0400
Received: from [194.213.32.142] ([194.213.32.142]:8708 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S266922AbRGHQ6k>;
	Sun, 8 Jul 2001 12:58:40 -0400
Date: Tue, 19 Jun 2001 13:09:15 +0000
From: Pavel Machek <pavel@suse.cz>
To: Pozsar Balazs <pozsy@sch.bme.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: very strange (semi-)lockups in 2.4.5
Message-ID: <20010619130915.A38@toy.ucw.cz>
In-Reply-To: <Pine.GSO.4.30.0106180858001.18443-100000@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.4.30.0106180858001.18443-100000@balu>; from pozsy@sch.bme.hu on Mon, Jun 18, 2001 at 09:05:51AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm having ~2 lockups a day. The following happens:
>  If I was under X, i only can use the magic-key, but no other keyboard (eg
> numlock) or mouse response, the screen freezes, processes stop.
>  If i was using textmode:
>   numlock still works
>   cursor blinks
>   processess stop (eg, gpm doesn't work, outputs freeze)
>   i can still switch vt's.
>   BUT, i can only type into a few vt's, last time into 3,5,6,7,8, but not
> into 1,2 or 4!
> 
> I cannot give you any traces, as i dont have any.
> 
> Also note that magic-key works, and it says that it umounts filesystems if
> i press magic-u, but next time at mount i see that reiserfs is replaying
> transactions.

I've seen something very similar yesterday, 2.4.5, PII/300, 64MB. 
MAGIC-s,u,b and ext2 came up clean.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

