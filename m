Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131988AbRCYO1G>; Sun, 25 Mar 2001 09:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131989AbRCYO05>; Sun, 25 Mar 2001 09:26:57 -0500
Received: from [195.63.194.11] ([195.63.194.11]:32018 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S131988AbRCYO0t>; Sun, 25 Mar 2001 09:26:49 -0500
Message-ID: <3ABDFD24.877A1FE9@evision-ventures.com>
Date: Sun, 25 Mar 2001 16:13:56 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Mike Galbraith <mikeg@wen-online.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <Pine.LNX.4.33.0103241039590.2310-100000@mikeg.weiden.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> 
> On Sat, 24 Mar 2001, Doug Ledford wrote:
> 
> [snip list of naughty behavior]
> 
> > What was that you were saying about "should *never* happen"?  Oh, and let's
> Get off your lazy butts and do something about it.  Don't work on the
> oom-killer though.. that's only a symptom.  Work on the problem instead.

You are absolutely right about the fact that there are serious
memmory balancing problems out there as well. But ther oom_killer.c
needs to be changed as well - becouse in it's current state it's
buggy as hell as well. You propably know that you earn stability
in SW systems by making them survive the borderline conditions...
