Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129564AbRBIWNo>; Fri, 9 Feb 2001 17:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129865AbRBIWNe>; Fri, 9 Feb 2001 17:13:34 -0500
Received: from saloma.stu.rpi.edu ([128.113.199.230]:57604 "HELO
	incandescent.mp3revolution.net") by vger.kernel.org with SMTP
	id <S129564AbRBIWNV>; Fri, 9 Feb 2001 17:13:21 -0500
From: dilinger@mp3revolution.net
Date: Fri, 9 Feb 2001 17:13:15 -0500
To: Zach Brown <zab@zabbo.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] maestro3 still oopses?
Message-ID: <20010209171315.A2938@incandescent.mp3revolution.net>
In-Reply-To: <20010208223103.A432@incandescent.mp3revolution.net> <20010209115148.B20335@tetsuo.zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010209115148.B20335@tetsuo.zabbo.net>; from zab@zabbo.net on Fri, Feb 09, 2001 at 11:51:48AM -0500
X-Operating-System: Linux incandescent 2.4.2-pre2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running it now, looks good.  :)

On Fri, Feb 09, 2001 at 11:51:48AM -0500, Zach Brown wrote:
> 
> > The maestro3 driver, included in 2.4.2-pre2 (which I assume is the
> > same as maestro3-2.4-20010204.tar.gz, I haven't bothered to try it;
> > I'm perfectly happy w/ my patch), oopses upon shutdown.
> 
> the maestro3 snapshot in 2.4.2pre2 is not up to date.  I imagine it came
> from alan, who got the jan30 patch, but didn't get the trivial feb 04
> patch that fixes the oops you're seeing.
> 
> the proper patch to 2.4.2-pre2 (and 2.4ac-current, presumably)
> is attached.  Does it fix you problem?  [it tries to do so without
> duplicating code, you'll notice.]
> 
> - z
> 

-- 
"... being a Linux user is sort of like living in a house inhabited
by a large family of carpenters and architects. Every morning when
you wake up, the house is a little different. Maybe there is a new
turret, or some walls have moved. Or perhaps someone has temporarily
removed the floor under your bed." - Unix for Dummies, 2nd Edition
        -- found in the .sig of Rob Riggs, rriggs@tesser.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
