Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263211AbTCSWGR>; Wed, 19 Mar 2003 17:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263212AbTCSWGR>; Wed, 19 Mar 2003 17:06:17 -0500
Received: from freeside.toyota.com ([63.87.74.7]:27578 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S263211AbTCSWGP>; Wed, 19 Mar 2003 17:06:15 -0500
Message-ID: <3E78EC63.9050308@tmsusa.com>
Date: Wed, 19 Mar 2003 14:17:07 -0800
From: jjs <jjs@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: elenstev@mesatop.com
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.65-mm2
References: <20030319012115.466970fd.akpm@digeo.com>	 <1048103489.1962.87.camel@spc9.esa.lanl.gov>	 <20030319121055.685b9b8c.akpm@digeo.com>	 <1048107434.1743.12.camel@spc1.esa.lanl.gov> <1048111359.1807.13.camel@spc1.esa.lanl.gov>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven P. Cole wrote:

>I repeated the tests with 2.5.65-mm2 elevator=deadline and the situation
>was similar to elevator=as.  Running dbench on ext3, the response to
>desktop switches and window wiggles was improved over running dbench on
>reiserfs, but typing in Evolution was subject to long delays with dbench
>clients greater than 16.
>
>I rebooted with 2.5.65-bk and ran dbench on ext3 again.  Everything was
>going smoothly, excellent interactivity, and then with dbench 28, the
>system froze.  No response to pings, no response to alt-sysrq-b (after
>alt-sysrq-s).  A hard reset was required.  Nothing interesting logged.
>Too bad.  Before it crashed, 2.5.65-bk was responding to typing in an
>Evolution new message window better than -mm2.
>

Just out of curiosity, what is the result of:

cat /proc/sys/sched/max_timeslice?

Does setting that to e.g. 50 make -mm2 smooth?

Joe

