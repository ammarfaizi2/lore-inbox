Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267708AbSLTCkQ>; Thu, 19 Dec 2002 21:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267705AbSLTCkQ>; Thu, 19 Dec 2002 21:40:16 -0500
Received: from packet.digeo.com ([12.110.80.53]:4485 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267700AbSLTCkP>;
	Thu, 19 Dec 2002 21:40:15 -0500
Message-ID: <3E0284EB.16A720ED@digeo.com>
Date: Thu, 19 Dec 2002 18:48:11 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] scheduler tunables with contest - prio_bonus_ratio
References: <3E0263EA.2BB9C89@digeo.com> <1040352135.2645.97.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Dec 2002 02:48:11.0710 (UTC) FILETIME=[3C56FDE0:01C2A7D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Thu, 2002-12-19 at 19:27, Andrew Morton wrote:
> 
> > Prefixing all the names with "tune_" would suit, too.
> 
> I have no problem with this.  Keeping the names in all caps rings
> "preprocessor define" to me, which in fact they are - but only insomuch
> as they point to a real variable.  So I dislike that.

Think of them as "runtime controllable constants" :)

> Personally I like them as normal variable names... don't you do the same
> in the VM code as well?  But tune_foo is fine..

Convention there is to use sysctl_foo, which is fine.  We haven't
been consistent in that, and it's a thing I regret.  But not
enough to bother changing it.
