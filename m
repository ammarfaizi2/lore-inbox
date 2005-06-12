Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262629AbVFLPsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbVFLPsv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 11:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbVFLPsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 11:48:51 -0400
Received: from soufre.accelance.net ([213.162.48.15]:19159 "EHLO
	soufre.accelance.net") by vger.kernel.org with ESMTP
	id S262629AbVFLPsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 11:48:30 -0400
Message-ID: <42AC5949.8070703@xenomai.org>
Date: Sun, 12 Jun 2005 17:48:25 +0200
From: Philippe Gerum <rpm@xenomai.org>
Organization: Xenomai
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kristian Benoit <kbenoit@opersys.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
References: <42AA6A6B.5040907@opersys.com>  <42AA812D.2060701@yahoo.com.au>	 <1118481315.9519.39.camel@sdietrich-xp.vilm.net> <1118499356.5786.16.camel@localhost>
In-Reply-To: <1118499356.5786.16.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Benoit wrote:
> On Sat, 2005-06-11 at 02:15 -0700, Sven-Thorsten Dietrich wrote:
> 
>>Its a good start, and its excellent that its being looked at. Thank
>>you
>>guys very much for taking the time to compare these 2 very different
>>systems. 
> 
> 
> Youre welcome !
> 
> 
>>I think the comparison should absolutely compare identical community
>>kernels. The comparison between two different release candidates is
>>questionable. rc2 to rc4 doesn't seem like much, after all, how much
>>code could go into a release candidate. (diff | wc -l) 
> 
> 
> I agree with that, but as the results show, there does'nt seems to be
> much difference impact the numbers in the tested field.
> 
> 
>>Also, I question testing -rc code in the first place, except for
>>regression purposes. 
> 
> 
> I tested the -rc code in orther to be able to compare the patched
> kernels against theird own source.
> 
> 
>>How does that effort compare for porting ADEOS code? If several weeks
>>of
>>work are invested in a comparison of rc2 to rc4, how much additional
>>work is needed to bring Adeos up to the base for the current RT
>>kernel?
>

It has already been done using 2.6.12-rc2/x86 + RT-V0.7.44-03 a few 
weeks ago. Since it was the first time such merge was attempted, it took 
me a week to get a functional patch which could run a complex "client" 
OS such as RTAI over it. Now that the infrastructure is in place, I 
guess that the task should be simpler, since hopefully, I now better 
understand the implications of having PREEMPT_RT into the kernel codebase.

> 
> Philippe, I think that question is youre !
> 

-- 

Philippe.
