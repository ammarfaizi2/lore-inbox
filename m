Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbTIRFj2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 01:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbTIRFj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 01:39:28 -0400
Received: from dyn-ctb-210-9-244-121.webone.com.au ([210.9.244.121]:23045 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262971AbTIRFj1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 01:39:27 -0400
Message-ID: <3F694509.60100@cyberone.com.au>
Date: Thu, 18 Sep 2003 15:39:21 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: bee71e@netscape.net
CC: linux-kernel@vger.kernel.org
Subject: Re: excessive swapping in 2.4.x
References: <7E768FF1.7BC13987.0005DAE9@netscape.net>
In-Reply-To: <7E768FF1.7BC13987.0005DAE9@netscape.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



bee71e@netscape.net wrote:

>Hi, 
>
>I am using 2.4.21 and I see an unusually large amount of swapping for relatively low load : 
>
>sample vmstat output: (note that the system is almost idle)
>
>  procs                      memory    swap          io     system         cpu
>r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
>0  2  0 1850220  10524   9412 703652 3030 1102  3912  1106 1506  1710   1   1  98
>0  2  0 1849188  10572   9388 700568 2780 376  3558   379 1434  1284   1   1  99
>0  5  0 1851576  11668   9404 698228 2999 479  3890   488 1499  1487   1   1  98
>
>Is this a known issue? Whats happening? How do I fix this?
>

You could try the latest 2.4 prerelease. It has some VM updates.


