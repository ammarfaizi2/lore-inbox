Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292804AbSCFBEG>; Tue, 5 Mar 2002 20:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292846AbSCFBD5>; Tue, 5 Mar 2002 20:03:57 -0500
Received: from [61.81.112.41] ([61.81.112.41]:30597 "EHLO atj.dyndns.org")
	by vger.kernel.org with ESMTP id <S292804AbSCFBDm>;
	Tue, 5 Mar 2002 20:03:42 -0500
Date: Wed, 6 Mar 2002 10:03:39 +0900 (KST)
From: TeJun Huh <tj@atj.dyndns.org>
Reply-To: tejun@aratech.co.kr
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysevq (kqueue equivalent)
In-Reply-To: <E16iPYJ-0004vn-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0203061000240.16197-100000@atj.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 6 Mar 2002, Alan Cox wrote:
> >  I wanna know two things. First, is there any plan to include some
> > event handling mechanism into the official kernel? Second, if so, am I
> > heading the right direction? Any comments are welcomed.
> 
> aio is pending going in. Asynchronous event notification with real time
> signals is already in and can be used as an event queue. Set the rt signal
> to use to be a real time one, mask it and pull it off the queue when you
> want. It hands you back the file handle.

 I don't really see how rt signals work with network i/o multiplexing.
Can you give me a pointer? Thx in advance.

-- 
with no alarms and no surprises,
no alarms and no surprises,
no alarms and no surprises please.                 - radiohead

