Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131459AbRCWUsl>; Fri, 23 Mar 2001 15:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131446AbRCWUsZ>; Fri, 23 Mar 2001 15:48:25 -0500
Received: from [195.63.194.11] ([195.63.194.11]:37644 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S131463AbRCWUrv>; Fri, 23 Mar 2001 15:47:51 -0500
Message-ID: <3ABBB329.31B51B2F@evision-ventures.com>
Date: Fri, 23 Mar 2001 21:33:45 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: SodaPop <soda@xirr.com>
CC: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <Pine.LNX.4.30.0103231423310.27259-100000@xirr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SodaPop wrote:
> 
> On Fri, 23 Mar 2001, Martin Dalecki wrote:
> 
> > SodaPop wrote:
> > >
> > > Rik, is there any way we could get a /proc entry for this, so that one
> > > could do something like:
> >
> > I will respond; NO there is no way for security reasons this is not a
> > good idea.
> >
> > > cat /proc/oom-kill-scores | sort +3
> 
> Oh, you mean like /proc/kcore is a bad idea for security reasons?

Yes. It should be the good old /dev/core anyway.
But its far more obscure to hack at, since it isn't plain text,
so basically it's far more difficult to get mands on it...
