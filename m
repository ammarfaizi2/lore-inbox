Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265680AbUABVnW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 16:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265683AbUABVnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 16:43:22 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:41232 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265680AbUABVnV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 16:43:21 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: md: RAID-6 patch available for testing
Date: Fri, 02 Jan 2004 16:26:42 -0500
Organization: TMR Associates, Inc
Message-ID: <bt4nvc$6vk$1@gatekeeper.tmr.com>
References: <bse2c7$viq$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1073079084 7156 192.168.12.10 (2 Jan 2004 21:31:24 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <bse2c7$viq$1@cesium.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> [Already announced to linux-raid, but I thought it might get wider
> distribution in this list.]
> 
> For those that don't know, I've been working on adding RAID-6 (dual
> failure recovery) to the md system for a while.  It started out as a
> project because the math was interesting, and Penguin Computing for
> donated a very much needed test system (thanks!)
> 
> Well, at least I have a piece of code that passes my relatively simple
> functionality tests.  Still, that's news, and this is the first RAID-6
> snapshot that isn't *known* to be broken :)
> 
> I can at least mount filesystems, read and write data, reboot the
> system and have the data still there, with 1 or 2 disks lost, and do a
> reconstruction once the drives are added back in.
> 
> New development snapshot at:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/raid6-20031224c-experimental.tar.gz
> 
> Please test it out and let me know how badly it sucks :)
> 
> At some point I'll try to run some benchmarks.  There is also a lot of
> optimization still to be done.

If this works as well as you intend, unless the performance is really 
broken it will still be useful in situations where data loss would be 
very painful. It wouldn't be bad in ad-hoc arrays I build from drives 
which have been pulled because they have too many POH or power cycles;-)

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
