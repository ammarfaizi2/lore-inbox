Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314095AbSDQPAm>; Wed, 17 Apr 2002 11:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314103AbSDQPAl>; Wed, 17 Apr 2002 11:00:41 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:4873 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S314095AbSDQPAk>; Wed, 17 Apr 2002 11:00:40 -0400
Date: Wed, 17 Apr 2002 10:57:59 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: bert hubert <ahu@ds9a.nl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: please merge 64-bit jiffy patches.
In-Reply-To: <20020417144231.A17983@outpost.ds9a.nl>
Message-ID: <Pine.LNX.3.96.1020417105014.32318A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2002, bert hubert wrote:

> On Wed, Apr 17, 2002 at 08:33:34AM -0400, Bill Davidsen wrote:
> 
> >   Other than a few things reporting wrong numbers, what costs do you
> > anticipate? I have servers in six USA states (four timezones) and I
> > haven't seen any real ill-effect on this.
> 
> I have been advised by Alan to treat the jiffy wraparound as a scheduled
> maintenance event. I tend to trust bearded kernel hackers from Wales.

  Alan has to be conservative, since he want to avoid giving potentially
damaging advice to someone. However, since you can take a reboot at your
convenience and schedule a year in advance, I still don't see the great
cost. If you have an app which must be up 7x24 and don't have seamless
backup you have other problems more serious than timer wrap.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

