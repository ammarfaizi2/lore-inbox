Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbTAaXJ2>; Fri, 31 Jan 2003 18:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263256AbTAaXJ2>; Fri, 31 Jan 2003 18:09:28 -0500
Received: from mail015.syd.optusnet.com.au ([210.49.20.173]:39811 "EHLO
	mail015.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S263246AbTAaXJ1> convert rfc822-to-8bit; Fri, 31 Jan 2003 18:09:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] ext3, reiser, jfs, xfs effect on contest
Date: Sat, 1 Feb 2003 10:18:37 +1100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, Alexander Zarochentcev <zam@namesys.com>,
       Dave Jones <davej@codemonkey.org.uk>
References: <200302010020.34119.conman@kolivas.net> <3E3ACEA8.8070504@namesys.com> <200302010921.59861.conman@kolivas.net>
In-Reply-To: <200302010921.59861.conman@kolivas.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302011018.37151.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 Feb 2003 9:21 am, Con Kolivas wrote:
> Actually the most "felt" of these loads is io_load and based on these
> results: io_load:
> Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
> 2559ext3        3       109     68.8    4       10.1    1.40
> 2559jfs         3       138     54.3    11      13.8    1.77
> 2559reiser      3       98      76.5    2       9.2     1.24
> 2559xfs         3       124     60.5    6       8.0     1.57
>

Here is a set of dbench_load results:
dbench_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2559ext3        3       115     65.2    3       24.3    1.47
2559jfs         3       123     61.8    3       19.5    1.58
2559reiser      3       108     69.4    3       13.9    1.37
2559xfs         3       118     63.6    3       22.0    1.49

Note the order correlates with the order of the io_load results.

Once again reiserfs held up kernel compilation the least. Note they all 
accomplished the same work in that time though.

Con
