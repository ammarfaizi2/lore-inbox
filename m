Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264555AbRFTWi7>; Wed, 20 Jun 2001 18:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264666AbRFTWiu>; Wed, 20 Jun 2001 18:38:50 -0400
Received: from sncgw.nai.com ([161.69.248.229]:16626 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S264555AbRFTWig>;
	Wed, 20 Jun 2001 18:38:36 -0400
Message-ID: <XFMail.20010620154145.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKOENMPPAA.davids@webmaster.com>
Date: Wed, 20 Jun 2001 15:41:45 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: David Schwartz <davids@webmaster.com>
Subject: RE: Why use threads ( was: Alan Cox quote?)
Cc: linux-kernel@vger.kernel.org, Larry McVoy <lm@bitmover.com>,
        Victor Yodaiken <yodaiken@fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20-Jun-2001 David Schwartz wrote:
> 
>> On Wed, Jun 20, 2001 at 02:01:16PM -0700, David Schwartz wrote:
> 
>> >    It's very hard to use processes for this purpose. Consider,
>> > for example, a
>> > web server. You don't want to use one process for each client
>> > because that
>> > would limit your scalability (16,000 clients would become difficult, and
>> > with threads it's trivial). You don't want to use one thread
>> > for each client
> 
>> How is it trivial? How do you debug a 16,000 thread application?
> 
>       As I said, you don't want to use one thread for each client. You use,
> say, 10 threads for the 16,000 clients.

Humm, you're going to select() over 1600 fds ...




- Davide

