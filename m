Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVCEVxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVCEVxR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 16:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVCEVxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 16:53:16 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:43429 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S261201AbVCEVxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 16:53:13 -0500
Date: Sat, 05 Mar 2005 16:53:12 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [PATCH] Re: diff command line?
In-reply-to: <20050305210850.GI30106@alpha.home.local>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200503051653.12290.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <fa.jshi2h6.1g20sjc@ifi.uio.no>
 <E1D7gBd-0000q3-3G@be1.7eggert.dyndns.org>
 <20050305210850.GI30106@alpha.home.local>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 March 2005 16:08, Willy Tarreau wrote:
>On Sat, Mar 05, 2005 at 09:47:44PM +0100, Bodo Eggert wrote:
>> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>> > On Sat, Mar 05, 2005 at 10:48:00AM -0500, Gene Heskett wrote:
>> >> What are the options normally used to generate a diff for
>> >> public consumption on this list?
>> >
>> > diff -urpN orig new
>> >
>> > where "orig" and "new" both contain the top level "linux"
>> > directory, so the resulting patch can be applied with patch -p1.
>>
>> This seems to be a common mistake.
>
>I often use a simple trick to make my single file patches compatible
>with both -p0 and -p1 :
>
>diff -pruN ./dir/file.orig ./dir/file.new
>
>The './' can either get stripped by -p1 or left as is, thus the
> patch works for different scripts or people. The main disadvantage
> is that there's no base version indication in the patch with this
> method.
>
>Regards,
>Willy

Neat, Willy.  Are such patches generally acceptable here?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
