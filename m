Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313530AbSDJSoK>; Wed, 10 Apr 2002 14:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313544AbSDJSoI>; Wed, 10 Apr 2002 14:44:08 -0400
Received: from smtp-out-7.wanadoo.fr ([193.252.19.26]:43769 "EHLO
	mel-rto7.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S313530AbSDJSnB>; Wed, 10 Apr 2002 14:43:01 -0400
Message-ID: <3CB48782.9000409@wanadoo.fr>
Date: Wed, 10 Apr 2002 20:42:10 +0200
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020407
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Duncan Sands <duncan.sands@math.u-psud.fr>,
        Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.8-pre2: preempt: exits with preempt_count 1
In-Reply-To: <E16vHbV-0000M5-00@baldrick> <1018463295.6681.18.camel@phantasy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> On Wed, 2002-04-10 at 08:53, Duncan Sands wrote:
> 
> 
>>error: halt[411] exited with preempt_count 1
>>
>>This was after about 24 hours of up time.  What can I do to help
>>track down this locking problem?

Duncan Sands wrote:
 > UP x86 K6 system running 2.5.8-pre3 with preemption.
 > Using usb-uhci.  I got the following bug when powering off:

It looks like one problem, caused by some usb device driver not exiting 
cleanly.

Pierre
-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

