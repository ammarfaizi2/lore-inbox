Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265037AbTBEWGl>; Wed, 5 Feb 2003 17:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265063AbTBEWGl>; Wed, 5 Feb 2003 17:06:41 -0500
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:37895
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S265037AbTBEWGk>; Wed, 5 Feb 2003 17:06:40 -0500
Message-ID: <3E418CDF.7020001@rackable.com>
Date: Wed, 05 Feb 2003 14:14:55 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Larson <plars@linuxtestproject.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Cerberus
References: <1044475584.30331.135.camel@plars>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Feb 2003 22:16:07.0547 (UTC) FILETIME=[2E3564B0:01C2CD64]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Larson wrote:

>I saw a comment late last week that someone was seeing cerberus crash
>instantaneously with 2.5 on UP machines, so I decided to try to
>reproduce this problem.  I got the latest version of ceerbuerus and put
>it on a single processor pIII-866 256MB ram, linux-2.5.59 kernel. 
>Newburn has been running for just under 5 days now without so much as a
>hiccup.
>
>1. Has anyone had first hand experience with this instability?
>
>2. If so, were you just running the default newburn, or something else? 
>Please let me know if you did something different that caused it to
>crash.
>  
>

  I've run Cerberus on a number of smp 2.5 kernels without issue.  You 
might try "./newburn -t -p 2".  Remember that you can fine tune your 
test by editing the newburn.tcf file.

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>



