Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317577AbSFMKPB>; Thu, 13 Jun 2002 06:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317578AbSFMKPA>; Thu, 13 Jun 2002 06:15:00 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:5640 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S317577AbSFMKO7>; Thu, 13 Jun 2002 06:14:59 -0400
Message-ID: <3D08711B.9070100@loewe-komp.de>
Date: Thu, 13 Jun 2002 12:16:59 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: Roberto Fichera <kernel@tekno-soft.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: Developing multi-threading applications
In-Reply-To: <5.1.1.6.0.20020613095304.00a6fc60@mail.tekno-soft.it> <5.1.1.6.0.20020613104128.02c119a0@mail.tekno-soft.it> <5.1.1.6.0.20020613115107.03b0d170@mail.tekno-soft.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Fichera wrote:
> At 11.44 13/06/02 +0200, Peter Wächtler wrote:
> 
>>> You are right! But "computational intensive" is not totaly right as I 
>>> say ;-),
>>> because most of thread are waiting for I/O, after I/O are performed the
>>> computational intensive tasks, finished its work all the result are sent
>>> to thread-father, the father collect all the child's result and 
>>> perform some
>>> computational work and send its result to its father and so on with many
>>> thread-father controlling other child. So I think the main 
>>> problem/overhead
>>> is thread creation and the thread's numbers.
>>
>>
>> Have a look at http://www-124.ibm.com/developerworks/opensource/pthreads/
>>
>> they provide M:N threading model where threads can live in userspace.
> 
> 
> Yes! I'm looking for it. But I want evaluate some other before.
> 

There is a paper rse-pmt.ps included in the tar archives from Ralf Engelschall
(author of GNU portable threads).

There you will find lots of interesting pointers to other thread packages.


