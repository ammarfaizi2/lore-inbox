Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285634AbRLGWw3>; Fri, 7 Dec 2001 17:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285637AbRLGWwN>; Fri, 7 Dec 2001 17:52:13 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:51902 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S285634AbRLGWv5>; Fri, 7 Dec 2001 17:51:57 -0500
Message-ID: <3C1147F2.4070103@us.ibm.com>
Date: Fri, 07 Dec 2001 14:51:30 -0800
From: "David C. Hansen" <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011206
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: "Udo A. Steinberg" <reality@delusion.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: release() locking
In-Reply-To: <3C10D83E.81261D74@delusion.de> <3C10FDCF.D8E473A0@zip.com.au> <3C11394D.90101@us.ibm.com> <3C113D78.F324F1B9@delusion.de> <3C113FB1.2000AFF1@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>"Udo A. Steinberg" wrote:
>
>>I guess there's something wrong with the changes you made, and it only
>>shows with the modifications that Andrew made - and since he says he
>>only fixed some bits of the code, the broken bits must have been there
>>before.
>>
>Maybe so.  Can you identify the exact kernel version at which
>the problem started?
>
The release() functions patch went into pre3.  It looks like Jens' bio 
changes went into pre4.  

