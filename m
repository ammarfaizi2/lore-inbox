Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSCRRWI>; Mon, 18 Mar 2002 12:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290277AbSCRRV6>; Mon, 18 Mar 2002 12:21:58 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:30456
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S290289AbSCRRVr>; Mon, 18 Mar 2002 12:21:47 -0500
Date: Mon, 18 Mar 2002 09:23:04 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Dave Jones <davej@suse.de>,
        Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        linux-kernel@vger.kernel.org
Subject: Re: [-ENOCOMPILE] ataraid as module in linux-2.5.7-pre2
Message-ID: <20020318172304.GJ2254@matchmail.com>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200203180938.g2I9c1q27846@Port.imtp.ilyichevsk.odessa.ua> <20020318142240.D3025@suse.de> <200203181341.g2IDfbq28679@Port.imtp.ilyichevsk.odessa.ua> <20020318145313.E3025@suse.de> <20020318164215.GI2254@matchmail.com> <20020318174527.C17410@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2002 at 05:45:27PM +0100, Dave Jones wrote:
> On Mon, Mar 18, 2002 at 08:42:15AM -0800, Mike Fedyk wrote:
>  > Dave, can you put kernel versions next to the problem reports?
>  > That way it'll be easier to see just how old the report is and see if it
>  > should be tested again (for testers) or fixed (for developers).
> 
>  At the top.   "Up to date as of 2.5.6pre1."
>  (Yes, I'm a the report is a whole 4 patches behind..
>   I'll fix it up maybe later tonight)
> 

2. Capable Of Corrupting Your FS/data.

    * Some reports of unknown cause of ext2 corruption since 2.5.3 (not
related to the missing i_fsize clearing from .3pre3-5)

It would be good to report the last version that this problem was reported
against, and this type of problem can't really be tested on each pre patch.
That's basically what I was asking for before...

==============

# IDE floppy oops on some (zip100) setups. (Triggers BUG_ON() in
elevator.c:237)

If the version is reported for this then you can see what function was being
reported at the time.  Otherwise some other patch could shift the contents
to make line 237 point to another function (rewrites and such...)

Mike
