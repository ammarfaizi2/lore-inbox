Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316585AbSFMKmm>; Thu, 13 Jun 2002 06:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317568AbSFMKml>; Thu, 13 Jun 2002 06:42:41 -0400
Received: from isolaweb.it ([213.82.132.2]:37394 "EHLO web.isolaweb.it")
	by vger.kernel.org with ESMTP id <S316585AbSFMKmk> convert rfc822-to-8bit;
	Thu, 13 Jun 2002 06:42:40 -0400
Message-Id: <5.1.1.6.0.20020613124139.03df22d0@mail.tekno-soft.it>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Thu, 13 Jun 2002 12:42:45 +0200
To: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: Developing multi-threading applications
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D08711B.9070100@loewe-komp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12.16 13/06/02 +0200, Peter Wächtler wrote:
>Roberto Fichera wrote:
>>At 11.44 13/06/02 +0200, Peter Wächtler wrote:
>>
>>>>You are right! But "computational intensive" is not totaly right as I 
>>>>say ;-),
>>>>because most of thread are waiting for I/O, after I/O are performed the
>>>>computational intensive tasks, finished its work all the result are sent
>>>>to thread-father, the father collect all the child's result and perform 
>>>>some
>>>>computational work and send its result to its father and so on with many
>>>>thread-father controlling other child. So I think the main problem/overhead
>>>>is thread creation and the thread's numbers.
>>>
>>>
>>>Have a look at http://www-124.ibm.com/developerworks/opensource/pthreads/
>>>
>>>they provide M:N threading model where threads can live in userspace.
>>
>>Yes! I'm looking for it. But I want evaluate some other before.

And I don't want use a library that's totally in userspace.


>There is a paper rse-pmt.ps included in the tar archives from Ralf Engelschall
>(author of GNU portable threads).
>
>There you will find lots of interesting pointers to other thread packages.

I'll take a look. Thanks!



>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

Roberto Fichera.

