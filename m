Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310334AbSCADsu>; Thu, 28 Feb 2002 22:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310349AbSCADrN>; Thu, 28 Feb 2002 22:47:13 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:34045
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S310341AbSCADph>; Thu, 28 Feb 2002 22:45:37 -0500
Date: Thu, 28 Feb 2002 19:46:26 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <20020301034626.GG2711@matchmail.com>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020301013056.GD2711@matchmail.com> <Pine.LNX.3.96.1020228221750.3310D-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1020228221750.3310D-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2002 at 10:26:48PM -0500, Bill Davidsen wrote:
> experience), so blessing one and making the other "only a patch" troubles
> me somewhat. I hate to say "compete" as VM solution, but they both solve
> the same problem with more success in one field or another.
> 
> If either is adopted the pressure will be off to improve in the areas
> where one or the other is weak, Once the decision is made that won't
> happen,

I sincerely doubt that Rik will slow down at all when parts of -aa are in
the mainline kernel.  There is 2.5 to work award, and 2.4 isn't a lost
cause... 

Also, one has already been blessed, way back in 2.4.10-pre11 by Linus.  I
don't see any chance of rmap getting into 2.4 before 2.4.27+  Marcelo has
said he wants to see rmap in production on in -ac for a while before he
thinks about merging rmap, and that's good IMHO.

>And if rmap is a large VM change, what then is Ardrea's code?
> Large isn't just the size of the patch, it is to some extent the size of
> the behavior change.
> 

True, and by that token, rmap would be the larger change in behavior (not
swapping on disk accesses, etc ;).

> For me it makes little difference, I like to play with kernels, and I'm
> hoping for the source which needs only numbers in /proc/sys to tune,
> rather than patches. But there are a lot more small machines (which I feel
> are better served by rmap) than large. I would like to leave the jury out
> a little longer on this.
> 

Look at it another way, by forcing Andrea to send it
in as small chunks with descriptions, we may finally get a documented -aa
VM. ;)  So, lets watch and see that happen.

I don't see anyone benefiting with *both* of the VM enhancements as external
patches.

> I was looking for opinions, thak you for sharing yours.!
>

You will certainly find that here. ;)
