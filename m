Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264879AbSJPFWw>; Wed, 16 Oct 2002 01:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264881AbSJPFWw>; Wed, 16 Oct 2002 01:22:52 -0400
Received: from [203.117.131.12] ([203.117.131.12]:36010 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S264879AbSJPFWv>; Wed, 16 Oct 2002 01:22:51 -0400
Message-ID: <3DACF908.70207@metaparadigm.com>
Date: Wed, 16 Oct 2002 13:28:40 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: J Sloan <joe@tmsusa.com>
Cc: GrandMasterLee <masterlee@digitalroadkill.net>,
       Simon Roscic <simon.roscic@chello.at>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
References: <200210152120.13666.simon.roscic@chello.at>	 <1034710299.1654.4.camel@localhost.localdomain>	 <200210152153.08603.simon.roscic@chello.at>	 <3DACD41F.2050405@metaparadigm.com> <1034740592.29313.0.camel@localhost> <3DACEB6E.6050700@metaparadigm.com> <3DACEC85.3020208@tmsusa.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LVM1 tried in numerous versions of 2.4.x both aa and rh version.

Every one i was getting oops when used with a combination
of ext3, LVM1 and qla2x00 driver.

Since taking LVM1 out of the picture, my oopsing problem has
gone away. This could of course not be LVM1's fault but the
fact that qla driver is a stack hog or something - i don't have
enough information to draw any conclusions all at the moment
i'm too scared to try LVM again (plus the time it takes to
migrate a few hundred gigs of storage).

~mc

On 10/16/02 12:35, J Sloan wrote:
> Just to make sure we are on the same page,
> was that LVM1, LVM2, or EVMS?
> 
> Joe
> 
> Michael Clark wrote:
> 
>> I doubt it will make a difference. LVM and qlogic drivers seem
>> to be a bad mix. I've already tried the beta5 of 6.01
>> and same problem exists - ooops about every 5-8 days.
>> Removing LVM and solved the problem.

