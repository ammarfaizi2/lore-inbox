Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132958AbRDWMD7>; Mon, 23 Apr 2001 08:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133005AbRDWMDt>; Mon, 23 Apr 2001 08:03:49 -0400
Received: from mail.valinux.com ([198.186.202.175]:21508 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S132958AbRDWMDo>;
	Mon, 23 Apr 2001 08:03:44 -0400
Message-ID: <3AE41A0C.5080103@valinux.com>
Date: Mon, 23 Apr 2001 06:03:24 -0600
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Swanson <swansma@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ALI 1541,K6,AGP 2.4.3-ac12 instability
In-Reply-To: <01042305140601.02063@test.home2.mark>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Swanson wrote:

> Hello,
> 
> When I enable AGP on my ALI system 2D seems to work fine but 3D causes
> kernel oops messages. (Ran through ksymoops) It looks like it could be
> an NVidia driver problem, but I doubt it as I run this with AGP at work with
> no problems. I'm wondering if anyone else has AGP working with the
> (new?) ALI AGP code.
> 
> Linux 2.4.3-ac12
> NVidia 0.9-769 drivers
> XFree86-4.0.3
> Ali 1541
> TNT2 rev 11 SGRAM 32MB
> (Recompiled the NVidia drivers to only use 1x AGP, and no ssb, and that
> didn't help. Also compiled in NVidia AGP code but this code didn't seem
> to understand what an ALI 1541 was and disabled AGP.)
> 
> Will test patches to help make this work if it is an ALI/Linux problem.
> 
> Thanks.
> 
This is an NVidia driver problem having to do with problems using 
agpgart with their latest drivers on 2.4.  I'm sure someone on the 
NVidia irc channel or their mailing list can help you.

-Jeff

