Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267628AbTAXKpg>; Fri, 24 Jan 2003 05:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267629AbTAXKpg>; Fri, 24 Jan 2003 05:45:36 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:29739 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id <S267628AbTAXKpf>; Fri, 24 Jan 2003 05:45:35 -0500
Message-ID: <3E311B72.9060508@users.sf.net>
Date: Fri, 24 Jan 2003 11:54:42 +0100
From: Thomas Tonino <ttonino@users.sf.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030116
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jakma <paulj@alphyra.ie>
CC: GrandMasterLee <masterlee@digitalroadkill.net>,
       Thomas Tonino <ttonino@users.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with Qlogic 2200 and 2.4.20
References: <Pine.LNX.4.44.0301231851080.31406-100000@dunlop.admin.ie.alphyra.com>
In-Reply-To: <Pine.LNX.4.44.0301231851080.31406-100000@dunlop.admin.ie.alphyra.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jakma wrote:

>>Just to chime in, are you using the qlogicfc driver that comes with
>>the kernel? If so, Try using qlogic's 6.01 driver set instead and
>>see if your problem goes away. I've had other problems, mostly stack
>>related, but I've since found my fixes
> 
> hmm.. i'd be very interested in them. I have found the qlogic v6 
> driver to dreadfully unstable under heavy load (eg multiple 
> bonnie++'s) on SMP.

I was planning to go use the qlogic 6.x driver, but only after a test.

For me, the in-kernel driver with the patch from Andrew Patterson is very stable 
on SMP. We'll have to see how the 6.x driver works out.

The in-kernel driver without patch is hopeless on single processor too. Uptime 
of 15 minutes or so when doing a resync, a bit more, but not much more than an 
hour, when doing less intensive IO.

In both cases with the "no handle slots, this should not happen" message. Both 
on Broadcom PIII boards - one Dell, one IBM.


Thomas

