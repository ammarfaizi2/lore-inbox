Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265130AbSJOXCQ>; Tue, 15 Oct 2002 19:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265129AbSJOXCQ>; Tue, 15 Oct 2002 19:02:16 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:1942 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265130AbSJOWvs>; Tue, 15 Oct 2002 18:51:48 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 15 Oct 2002 16:05:49 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: John Gardiner Myers <jgmyers@netscape.com>
cc: Benjamin LaHaise <bcrl@redhat.com>, Dan Kegel <dank@kegel.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
In-Reply-To: <3DAC9859.5060005@netscape.com>
Message-ID: <Pine.LNX.4.44.0210151601560.1554-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2002, John Gardiner Myers wrote:

> Nonetheless, the requirement for user space to test the condition after
> the registration, not before, is subtle.  A program which does these in
> the wrong order is still likely to pass QA and will fail in production
> in a way that will be difficult to diagnose.  There is no rational
> reason for the kernel to not test the condition upon registration.

All APIs have their own specifications and if you do not follow them, or
you're using a different interfacing just because the name looks similar
to other APIs, you're going to have problems. The problem it's not inside
the API but inside the user ...



- Davide


