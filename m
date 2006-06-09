Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030417AbWFITNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbWFITNz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbWFITNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:13:54 -0400
Received: from relay03.pair.com ([209.68.5.17]:27155 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1030261AbWFITNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:13:53 -0400
X-pair-Authenticated: 71.197.50.189
Date: Fri, 9 Jun 2006 14:13:51 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Chase Venters <chase.venters@clientec.com>,
       Linus Torvalds <torvalds@osdl.org>, Alex Tomas <alex@clusterfs.com>,
       Andreas Dilger <adilger@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
In-Reply-To: <1149880865.22124.70.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0606091411360.5541@turbotaz.ourhouse>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> 
 <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> 
 <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> 
 <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>  <m33beecntr.fsf@bzzz.home.net>
  <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>  <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
  <20060609181020.GB5964@schatzie.adilger.int>  <Pine.LNX.4.64.0606091114270.5498@g5.osdl.org>
  <m31wty9o77.fsf@bzzz.home.net>  <Pine.LNX.4.64.0606091137340.5498@g5.osdl.org>
  <Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse>
 <1149880865.22124.70.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2006, Alan Cox wrote:

> Ar Gwe, 2006-06-09 am 13:50 -0500, ysgrifennodd Chase Venters:
>> It's about bundling. It's about being able to take your 3-year old
>> dependable car and make it faster by bolting on new manifolds and
>> turbochargers, rather than waiting a year for the manufacturer to release
>> a totally new model
>
> Unfortunately in the software case if you want it in the base kernel you
> are bolting new manifolds on everyones car at once, and someone is going
> to have an engine explode as a result.

Someone _could_ have an engine explode... it's perfectly possible though 
that a well-tested 48-bit patch wouldn't cause anyone's ext3 to explode. 
(After all, the vehicle analogy breaks down here - software doesn't get 
worn out from being run at redline for too many miles.)

> Ext3 already has enough back compatiblity that you can replace the
> engine with a horse, we don't need any more in it thank you.

But just what are the costs at calling it quits now? Are we going to deny 
users something they need?

>
> Alan
>
