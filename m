Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316826AbSGBRC1>; Tue, 2 Jul 2002 13:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316827AbSGBRC0>; Tue, 2 Jul 2002 13:02:26 -0400
Received: from ns.escriba.com.br ([200.250.187.130]:11001 "EHLO
	alexnunes.lab.escriba.com.br") by vger.kernel.org with ESMTP
	id <S316826AbSGBRC0>; Tue, 2 Jul 2002 13:02:26 -0400
Message-ID: <3D21DD2A.2010801@PolesApart.wox.org>
Date: Tue, 02 Jul 2002 14:04:42 -0300
From: "Alexandre P. Nunes" <alex@PolesApart.wox.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020610
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.19-pre10-ac2 bug in page_alloc.c:131
References: <Pine.LNX.3.96.1020702120824.28259A-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

>On Mon, 24 Jun 2002, David S. Miller wrote:
>
>  
>
>>This has to do with facts, not opinions.  Since we lack the source to
>>their drivers, we have no idea if some bug in their driver is
>>scribbling over (ie. corrupting) memory.  It is therefore an unknown
>>which makes it a waste of time for us to pursue the bug report.
>>    
>>
>
>By that logic if source is freely available the kernel should not be
>marked tainted, even if the source license is not GPL, as in you can get
>it and use it to debug, but the license is something like BSD, or the
>Kermit limited redistribution, etc.
>
>I'm asking in general, not about just one particular binary-only driver.
>
>  
>

How this taint stuff works, actually ? It's just a marker or it impose 
any restrictions?

While I made all efforts to send nvidia all information pertinent to the 
reported bug, I also found that the source to o/s dependent parts are in 
fact (at least partially) available, with an absurdly restrictive 
license, though. If someone else is interested in looking at, one of the 
files in the distribution contains the mm code and all general 
interfacing to the kernel.

I agree it's nvidia responsability for checking its own source, but help 
is always welcome when it's true help after all.

In last weekend I patched 2.4.19-pre10-ac2 with the last preempt-kernel 
patch, and since I was unable to reproduce the crash, though I didn't 
stress the machine enough by lack of time, so it's just informative 
report in case someone want to try.

Cheers,

Alexandre


