Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313087AbSDYLxx>; Thu, 25 Apr 2002 07:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313089AbSDYLxw>; Thu, 25 Apr 2002 07:53:52 -0400
Received: from mx1-corp.corp.nl.home.com ([212.120.66.113]:1675 "EHLO
	mx1-corp.corp.nl.home.com") by vger.kernel.org with ESMTP
	id <S313087AbSDYLxv>; Thu, 25 Apr 2002 07:53:51 -0400
From: Thomas Tonino <ttonino@corp.home.nl>
To: linux-kernel@vger.kernel.org
Message-ID: <3CC7EDC0.9080509@corp.home.nl>
Date: Thu, 25 Apr 2002 13:51:28 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020416
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: Re: sard/iostat disk I/O statistics/accounting for 2.5.8-pre3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zlatko Calusic wrote:

> All this gives Linux a much needed functionality - extensive
> measurements and reporting of disk device performance/bottlenecks.
> No server should be without it. See below for a real life story.
> 
> The patch, iostat utility and man page can be found at
> 
>  <URL:http://linux.inet.hr/> 

This is very useful functionality. I'm currently looking at a similar 
patch for the 2.4 series, taken from

http://www.kernel.at/pub/linux/kernel/people/hch/patches/v2.4/2.4.18-pre4/

which seems to work fine so far (with very limited testing). This patch 
gives information that is really needed to maintain systems that 
actually use their disks, such as mail, database and news servers.

May I vote for inclusion in the mainline kernel, both 2.4 and 2.5? 
Again, it is an important part of server maintainability.


Thomas
