Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274843AbRIUVcy>; Fri, 21 Sep 2001 17:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274844AbRIUVcp>; Fri, 21 Sep 2001 17:32:45 -0400
Received: from [208.129.208.52] ([208.129.208.52]:25871 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S274843AbRIUVc2>;
	Fri, 21 Sep 2001 17:32:28 -0400
Message-ID: <XFMail.20010921143623.davidel@xmailserver.org>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3BABA15A.57255E63@distributopia.com>
Date: Fri, 21 Sep 2001 14:36:23 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: "Christopher K. St. John" <cks@distributopia.com>
Subject: Re: /dev/yapoll : Re: [PATCH] /dev/epoll update ...
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 21-Sep-2001 Christopher K. St. John wrote:
> Davide Libenzi wrote:
>> 
>> By reporting the initial state of the connection will
>> make /dev/epoll to be a hybrid interface
>>
> 
>  Yes, but you need that anyway (see below)
> 
> 
>> and looks pretty crappy to me.
>>
> 
>  It turns out that a hybrid interface is needed
> in any case to handle overload. When the queues
> start to fill up, you need to back off and start
> basically doing something like a plain-old-poll()
> instead. Ref the paper. Here's a link to a kernel
> list dicussion that covers similiar ground:

Now, my question born spontaneously :

"Did you read and understood the /dev/epoll code ?"

If yes, could you explain to me a case where /dev/epoll users have
to fall back doing "plain-old-poll()" ?



- Davide

