Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265832AbRFYA4Z>; Sun, 24 Jun 2001 20:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265831AbRFYA4Q>; Sun, 24 Jun 2001 20:56:16 -0400
Received: from sncgw.nai.com ([161.69.248.229]:33978 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S265829AbRFYA4B>;
	Sun, 24 Jun 2001 20:56:01 -0400
Message-ID: <XFMail.20010624175903.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.10.10106241726460.14567-100000@innerfire.net>
Date: Sun, 24 Jun 2001 17:59:03 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Gerhard Mack <gmack@innerfire.net>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Cc: "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Cc: "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
        Timur Tabi <ttabi@interactivesi.com>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        landley@webofficenow.com, Larry McVoy <lm@bitmover.com>,
        "J . A . Magallon" <jamagallon@able.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 25-Jun-2001 Gerhard Mack wrote:
>> BTW, after all I have read all POSIX threads library should be no more than
>> a wrapper over fork(), clone and so on. Why are they so bad then ?
>> I am going to get glibc source to see what is inside pthread_create...
> 
> If I recall it had to do with problems in signal delivery...

1) pthread_create() does not create the thread, it write through a pipe to a
        thread manager that will create a thread

2) pthread ( in linux ) is signal intensive




- Davide

