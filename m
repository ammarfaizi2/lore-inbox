Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbVCLAEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVCLAEK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 19:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVCKX4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 18:56:15 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:15044 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S261826AbVCKXw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 18:52:56 -0500
Date: Fri, 11 Mar 2005 18:52:48 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: AGP bogosities
In-reply-to: <20050311223336.GB20551@taniwha.stupidest.org>
To: linux-kernel@vger.kernel.org
Cc: Chris Wedgwood <cw@f00f.org>, Dave Jones <davej@redhat.com>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       benh@kernel.crashing.org
Reply-to: gene.heskett@verizon.net
Message-id: <200503111852.49086.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
 <20050311222614.GH4185@redhat.com>
 <20050311223336.GB20551@taniwha.stupidest.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 March 2005 17:33, Chris Wedgwood wrote:
>On Fri, Mar 11, 2005 at 05:26:14PM -0500, Dave Jones wrote:
>> Does no-one read dmesg output any more?
>
>For many people it's overly verbose and long --- so I assume they
> just tune it out.
>
>Sometimes I wonder if it would be a worth-while effort to trim the
>dmesg boot text down to what users really *need* to know.  We could
>retain most of the other stuff at a different log-level which would
> be exposed by a kernel command line parameter or something during
> boot for when people have problems.

With all due respect to the people that it will take to make that 
happen, thats a heck of a good idea.  However, what I'd like to see 
is a difference between whats output to the screen during bootup (set 
that to relatively quiet unless a problem is hit) but to continue to 
log the full output to /var/log/dmesg-$date when the ring is dumped 
and syslog can then take the rest of it.

Overwriting /var/log/dmesg at every boot removes a lot of forensic 
info that could come in handier than sliced bread and bottled beer at 
times.  Let rotatelog take care of deleting anything more than a week 
out of date so they don't take up space once their usefullness has 
expired.

How many 'aye's do I hear?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
