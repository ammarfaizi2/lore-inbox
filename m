Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbTAaQbB>; Fri, 31 Jan 2003 11:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261599AbTAaQbB>; Fri, 31 Jan 2003 11:31:01 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:47238 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S261594AbTAaQbA>; Fri, 31 Jan 2003 11:31:00 -0500
Message-ID: <3E3AA6F6.3090504@namesys.com>
Date: Fri, 31 Jan 2003 19:40:22 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] ext3, reiser, jfs, xfs effect on contest
References: <200302010020.34119.conman@kolivas.net> <3E3A7C22.1080709@namesys.com> <200302010040.49141.conman@kolivas.net> <3E3A8077.9050409@namesys.com> <20030131152156.GA15977@codemonkey.org.uk>
In-Reply-To: <20030131152156.GA15977@codemonkey.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>On Fri, Jan 31, 2003 at 04:56:07PM +0300, Hans Reiser wrote:
> > Try running with the -E option for gcc, it might be less CPU intensive, 
> > and thus a better FS benchmark.
> > 
> > What do you think?
>
>It's hardly a realistic real-world benchmark if you start nobbling
>bits of it though.  Not reading the preprocessed output is sure
>to bump the benchmark points on an fs optimised for lots of small
>writes.
>
>		Dave
>
>  
>
Sigh.  The alternative is to strace the compile, write a perl scipt or 
something to get just the FS related calls out of it, and then create a 
program with just the FS related calls.  gcc -E sounds easier to me.;-)

-- 
Hans


