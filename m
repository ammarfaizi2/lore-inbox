Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVHDHQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVHDHQp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 03:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbVHDHQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 03:16:45 -0400
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:25006 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261937AbVHDHQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 03:16:43 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Jim MacBaine <jmacbaine@gmail.com>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Date: Thu, 4 Aug 2005 17:12:31 +1000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com
References: <200508031559.24704.kernel@kolivas.org> <3afbacad05080323596b39e9eb@mail.gmail.com> <200508041704.37026.kernel@kolivas.org>
In-Reply-To: <200508041704.37026.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508041712.31972.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2005 05:04 pm, Con Kolivas wrote:
> On Thu, 4 Aug 2005 04:59 pm, Jim MacBaine wrote:
> > I just borrowed a power meter to see (or not to see) real effects of
> > dyntick. The difference between static 1000 HZ and dynamic HZ is much
> > less than I expected, only a very little about noise.  With dyntick
> > disabled at 1000 HZ my laptop needs 31,3 W.  With dyntick enabled I
> > get 29.8 W, the pmstats-0.2 script shows me that the system is at
> > 35-45 HZ when it is idle.
> >
> > The power consumption difference between 250 HZ static and dyntick is
> > below the noise, so maybe hardly worth all the struggle.
>
> That's not the point. We want the power savings without sacrificing the
> extra ticks if we need them.

Oh but thank you very much for confirming the power savings are around the 5% 
mark. If we don't measure we won't know (and everything else is mental 
masturbation according to Linus ;)).

Cheers,
Con
