Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270446AbRHWVOR>; Thu, 23 Aug 2001 17:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270373AbRHWVOB>; Thu, 23 Aug 2001 17:14:01 -0400
Received: from sncgw.nai.com ([161.69.248.229]:38064 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S270382AbRHWVNb>;
	Thu, 23 Aug 2001 17:13:31 -0400
Message-ID: <XFMail.20010823141714.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3B6B662F.3E83C22F@kegel.com>
Date: Thu, 23 Aug 2001 14:17:14 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Dan Kegel <dank@kegel.com>
Subject: RE: Could /dev/epoll deliver aio completion notifications? (was:
Cc: Zach Brown <zab@zabbo.net>
Cc: Zach Brown <zab@zabbo.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christopher Smith <x@xman.org>, Petru Paler <ppetru@ppetru.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04-Aug-2001 Dan Kegel wrote:
> Davide, is that along the lines of what you were thinking of
> for /dev/epoll and disk files?   (Plain old polling of disk
> files doesn't make much sense unless you're just interested in
> them growing, I suppose; aio completion notification is what you 
> really want.)

Dan, sorry for the response delay but I was in Vacation Mode ( new CPU execution mode
that will be included in the next x86 generation ).
I trashed my original idea to extend /dev/epoll to other other files coz this will make the
patch way more intrusive. The only easy extension that comes in my mind is pipes.
As soon as I'll finish to read the remaining 4231 messages in my mbox I'll fix /dev/epoll
to get rid of stale events that I ( and Erich Nahum ) noticed in the current implementation.



- Davide

