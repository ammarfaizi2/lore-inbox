Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319766AbSIMVDB>; Fri, 13 Sep 2002 17:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319787AbSIMVDB>; Fri, 13 Sep 2002 17:03:01 -0400
Received: from host.greatconnect.com ([209.239.40.135]:55058 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S319766AbSIMVDA>; Fri, 13 Sep 2002 17:03:00 -0400
Message-ID: <3D825422.8000007@rackable.com>
Date: Fri, 13 Sep 2002 14:09:54 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Stephen Lord <lord@sgi.com>, Austin Gonyou <austin@coremetrics.com>,
       Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
Subject: Re: 2.4.20pre5aa2
References: <20020911201602.A13655@pc9391.uni-regensburg.de> <1031768655.24629.23.camel@UberGeek.coremetrics.com> <20020911184111.GY17868@dualathlon.random> <3D81235B.6080809@rackable.com> <20020913002316.GG11605@dualathlon.random> <1031878070.1236.29.camel@snafu> <20020913005440.GJ11605@dualathlon.random> <3D8149F6.9060702@rackable.com> <20020913125345.GO11605@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

>  
>
>you can try to compile with CONFIG_3G and to set __VMALLOC_RESERVE to
>(512 << 20) and see if it helps. If it only happens a bit later then
>it's most probably an address space leak, should be easy to track down
>some debugging instrumentation.
>  
>


  It seems to be working for me now.  I'm getting about 200 on dbench 4, 
and 90 on dbench 64.  (Note you need to increase your log size to get 
these kinda of numbers.)  Now I get to see how fast I can read files via 
nfs.

