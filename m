Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbVIRVnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbVIRVnd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 17:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbVIRVnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 17:43:33 -0400
Received: from sccimhc91.asp.att.net ([63.240.76.165]:39568 "EHLO
	sccimhc91.asp.att.net") by vger.kernel.org with ESMTP
	id S932214AbVIRVnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 17:43:32 -0400
Message-ID: <432DDF7A.3050704@teleformix.com>
Date: Sun, 18 Sep 2005 16:43:22 -0500
From: Dan Oglesby <doglesby@teleformix.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       Hans Reiser <reiser@namesys.com>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl> <432DCE2A.5070705@slaphack.com>
In-Reply-To: <432DCE2A.5070705@slaphack.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover wrote:

> Horst von Brand wrote:
>
>> There are lots of reports of ReiserFS 3
>> filesystems completely destroyed by minor hardware flakiness.
>
>
> Honestly, this is one of the things I like about Linux.  If I have 
> memory errors, Windows will just keep running, occasionally something 
> will crash, you restart it, never suspecting just how corrupt things 
> are getting under the hood.  On Linux, I generally get kernel panics 
> pretty quickly, so I run memtest86 and replace the RAM.
>
> If my hardware is flaky, I consider it my job to replace it, not the 
> job of all my software to magically compensate for it.  If I lose 
> data, oh well, I have backups.  If I didn't, I was asking for trouble 
> anyway.

I'm of the same opinion.  If I have hardware that has a problem, and 
causes downtime, it gets replaced or repaired.  I don't switch to a 
different piece of software to compensate for broken hardware.

With that said, I have seen ReiserFS expose hardware that had problems.  
Hardware was repaired, and ReiserFS rides again.

--Dan
