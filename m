Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284970AbSANPFJ>; Mon, 14 Jan 2002 10:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285828AbSANPFB>; Mon, 14 Jan 2002 10:05:01 -0500
Received: from maynard.mail.mindspring.net ([207.69.200.243]:8965 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S285692AbSANPEt>; Mon, 14 Jan 2002 10:04:49 -0500
Message-ID: <3C42F477.7090508@elegant-software.com>
Date: Mon, 14 Jan 2002 10:08:39 -0500
From: Russ Leighton <russ@elegant-software.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.14-5.0 i686; en-US; 0.8) Gecko/20010216
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <3C41A545.A903F24C@linux-m68k.org> <20020113153602.GA19130@fenrus.demon.nl> <E16PzHb-00006g-00@starship.berlin> <20020113223438.A19324@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is getting silly ... feeback like "ll is better than PK", "feels 
smooth", "is reponsive",  "my kernel
compile is faster than yours", etc. is not getting us any closer to the 
"how" of making a better kernel.

What's the goal? How should SMP and NUMA behave? How is success measured?

It would be good to be very clear on the ultimate purpose before making 
radical changes. All of
these changes are dancing around some vague concept of 
reponsiveness...so define it!

These comments seem to set a better tone for this thread, perhaps we can 
concentrate  on _useful_ debate
around some well defined goal.

yodaiken@fsmlabs.com wrote:

> The key one is some idea of being able to assure processes
> of some rate of progress.  This is not classical RT, but it is important to multimedia and 
> databases and also to some applications we are interested in looking at. 


Andrew Morton wrote:

> But we can **make** it useful.  I believe that internal preemption is
> the foundation to improve 2.5 kernel latency.  But first we need
> consensus that we **want** linux to be a low-latency kernel.
> 
> Do we have that?
> 
> If we do, then as I've said before, holding a lock for more than N milliseconds
> becomes a bug to be fixed.  We can put tools in the hands of testers to
> locate those bugs.  Easy.
> 

