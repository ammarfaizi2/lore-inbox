Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317593AbSGJUBC>; Wed, 10 Jul 2002 16:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317597AbSGJUBC>; Wed, 10 Jul 2002 16:01:02 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:33275 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317593AbSGJUBA>; Wed, 10 Jul 2002 16:01:00 -0400
Subject: Re: [STATUS 2.5]  July 10, 2002
From: Robert Love <rml@tech9.net>
To: Ville Herva <vherva@niksula.hut.fi>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020710191824.GT1548@niksula.cs.hut.fi>
References: <3D2B89AC.25661.91896FEB@localhost>
	<1026323661.1178.73.camel@sinai>  <20020710191824.GT1548@niksula.cs.hut.fi>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 10 Jul 2002 13:03:38 -0700
Message-Id: <1026331418.1244.82.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-10 at 12:18, Ville Herva wrote:
> On Wed, Jul 10, 2002 at 10:54:21AM -0700, you [Robert Love] wrote:
> > 
> > As of 2.5.25, we have HZ=1000 (on x86) and a scalable user-space
> > exported clock_t that remains at 100 HZ to keep user-space compatible. 
> > This is attributed to the Commander in Chief, Linus Torvalds.
> 
> But jiffies now wrap at 49.7 days, right? If so, did Tim Schmielau's jiffies
> wrap patches go in as well? ISTR they went in -dj.

George Anzinger's 64-bit jiffies are in 2.5.

Tim's code to better utilize them is in 2.5 I _think_.

> Didn't Red Hat change HZ to 1000 (or 1024) in Limbo as well? How did they
> handle that?

Yes, RedHat's current devel kernel is using HZ=1000.  I am not sure how
they handled it.  What we have in 2.5 now is correct.

	Robert Love

