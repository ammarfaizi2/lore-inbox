Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264460AbTE1AYg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 20:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbTE1AYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 20:24:36 -0400
Received: from dyn-ctb-203-221-73-224.webone.com.au ([203.221.73.224]:21765
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S264460AbTE1AYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 20:24:35 -0400
Message-ID: <3ED3FBD9.1040701@cyberone.com.au>
Date: Wed, 28 May 2003 09:59:21 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Joel Becker <Joel.Becker@oracle.com>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: WimMark I report for 2.5.70-mm1
References: <20030527225519.GL32128@ca-server1.us.oracle.com> <20030527164612.3249bfe5.akpm@digeo.com>
In-Reply-To: <20030527164612.3249bfe5.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Joel Becker <Joel.Becker@oracle.com> wrote:
>
>>WimMark I report for 2.5.70
>>
>>Runs:  1005.78 958.80 947.23
>>
>>WimMark I report for 2.5.70-mm1
>>
>>Runs (deadline): 717.27 1064.57 1089.13
>>Runs (anticipatory):  1342.93 1121.47 1330.42
>>...
>>	WimMark I run results are archived at
>>http://oss.oracle.com/~jlbec/wimmark/wimmark_I.html
>>
>
>This is nuts.  WimMark keeps on showing 2:1 swings in throughput when no
>other test shows any variation at all.  I simply do not know what to make
>of it.
>
>Your results would appear to indicate that the regression between
>2.5.69-mm5 and 2.5.69-mm8 was actually due to something in Linus's tree,
>and it is now in 2.5.70.
>
>I have an interdiff here between the linus.patch from mm5 and mm8 and it
>contains nothing very interesting.
>
It might be something from your tree that got into Linus' _after_ mm8?

