Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312988AbSDSVQx>; Fri, 19 Apr 2002 17:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312996AbSDSVQw>; Fri, 19 Apr 2002 17:16:52 -0400
Received: from wotug.org ([194.106.52.201]:13316 "EHLO gatemaster.ivimey.org")
	by vger.kernel.org with ESMTP id <S312988AbSDSVQv>;
	Fri, 19 Apr 2002 17:16:51 -0400
Message-Id: <5.1.0.14.0.20020419204810.01e5a270@mailhost.ivimey.org>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 19 Apr 2002 20:51:38 +0100
To: Andrew Morton <akpm@zip.com.au>
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Subject: Re: Kernel BUG in ext3 (2.4.18pre1)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CBF4B13.38B20491@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 23:39 18/04/2002, you wrote:
>Ruth Ivimey-Cook wrote:
> >
> > ...
> > Apr 17 23:20:01 gatemaster kernel: Assertion failure in
> > __journal_file_buffer() at transaction.c:1935: "jh->b_jlist < 9"
> > Apr 17 23:20:01 gatemaster kernel: kernel BUG at transaction.c:1935!
>
>That's the first time this has been reported.  Conceivably,
>ext3 has corrupted the journal_head.  More conceivably, some
>other part of the kernel scribbled on it.  Most conceivably,
>your memory flipped a bit.
>
>Best I can suggest is that you give the machine an overnight
>run with memtest86.

I gave the machine a 2-hour run with memtest 2.9. It passed one basic test 
and 3 extended tests before I decided the website the machine serves just 
had to get back online :-/

I suppose I could try again sometime, but with 0 errors from memtest, I 
would prefer not to if I can...

Ruth

