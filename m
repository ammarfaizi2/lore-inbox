Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313638AbSDJT3b>; Wed, 10 Apr 2002 15:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313641AbSDJT3a>; Wed, 10 Apr 2002 15:29:30 -0400
Received: from ip68-7-112-74.sd.sd.cox.net ([68.7.112.74]:2821 "EHLO
	clpanic.kennet.coplanar.net") by vger.kernel.org with ESMTP
	id <S313638AbSDJT33>; Wed, 10 Apr 2002 15:29:29 -0400
Message-ID: <004b01c1e0c6$01d690f0$7e0aa8c0@bridge>
From: "Jeremy Jackson" <jerj@coplanar.net>
To: "Andrew Morton" <akpm@zip.com.au>, "lkml" <linux-kernel@vger.kernel.org>
In-Reply-To: <3CB4203D.C3BE7298@zip.com.au>
Subject: Re: [prepatch] address_space-based writeback
Date: Wed, 10 Apr 2002 12:29:17 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This sounds like a wonderful piece of work.
I'm also inspired by the rmap stuff coming down 
the pipe.   I wonder if there would be any interference
between the two, or could they leverage each other?

Jeremy

----- Original Message ----- 
From: "Andrew Morton" <akpm@zip.com.au>
Sent: Wednesday, April 10, 2002 4:21 AM


> 
> This is a largish patch which makes some fairly deep changes.  It's
> currently at the "wow, it worked" stage.  Most of it is fairly
> mature code, but some conceptual changes were recently made.
> Hopefully it'll be in respectable state in a few days, but I'd
> like people to take a look.
> 
> The idea is: all writeback is against address_spaces.  All dirty data
> has the dirty bit set against its page.  So all dirty data is
> accessible by
 (snip)
