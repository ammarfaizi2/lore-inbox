Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313125AbSFNRhp>; Fri, 14 Jun 2002 13:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313202AbSFNRhp>; Fri, 14 Jun 2002 13:37:45 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:3573 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S313125AbSFNRho>; Fri, 14 Jun 2002 13:37:44 -0400
Subject: Re: [PATCH] 2.4-ac: sparc64 support for O(1) scheduler
From: Robert Love <rml@mvista.com>
To: "David S. Miller" <davem@redhat.com>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020613.212528.08026527.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 14 Jun 2002 10:32:32 -0700
Message-Id: <1024075953.4799.224.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-06-13 at 21:25, David S. Miller wrote:

> Ummm what is with all of those switch_mm() hacks?  Is this an attempt
> to work around the locking problems?  Please don't do that as it is
> going to kill performance and having ifdef sparc64 sched.c changes is
> ugly to say the least.
>
> Ingo posted the correct fix to the locking problem with the patch
> he posted the other day, that is what should go into the -ac patches.

I am explicitly refraining from sending Alan any code that is not
well-tested in 2.5 and my machines first.  As Ingo's new switch_mm()
bits are not even in 2.5 yet, I plan to wait a bit before sending
them... (I am currently putting together all the scheduler bits we have
been working on for a 2.4-ac patch...)

If you like, Alan can hold off on this and take it when the appropriate
patches are in.

	Robert Love


