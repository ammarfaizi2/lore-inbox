Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316585AbSHJEQM>; Sat, 10 Aug 2002 00:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316587AbSHJEQM>; Sat, 10 Aug 2002 00:16:12 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:15749 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S316585AbSHJEQL>; Sat, 10 Aug 2002 00:16:11 -0400
Date: Fri, 9 Aug 2002 21:19:41 -0700
To: Greg Fitzgerald <gregf@closeedge.net>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, adilger@clusterfs.com
Subject: Re: ext3 journal/IDE problems ?
Message-ID: <20020810041941.GA4192@gnuppy.monkey.org>
References: <20020809040456.GA786@gnuppy.monkey.org> <20020809110938.24de8a00.gregf@closeedge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020809110938.24de8a00.gregf@closeedge.net>
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2002 at 11:09:38AM -0400, Greg Fitzgerald wrote:
> I have been having problems with ext3 hardlocking while in X and in
> Console. Symptom one is while in console moving large ammounts of data
> around between partions it will hardlock. Symptom two is sometimes I
> will leave my computer for a few minutes (on a very rar occasion :P )
> when i return x is hardlocked. Was running XFS and Resierfs before I
> tried ext3 and never had these problems. Any information I can provide
> let me know.

I use to get those hard locks, but I wasn't sure if was my hardware or
the kernel using preempt. After using 2.5.30 for a while, those lock ups
went away, but the progression to this bug happen first with a scheduler
crash in the TCP/IP stack being triggered and then after that application of
Mingo's patch (from a previous email) that fixed the crashes, it started
to trigger ext3 assertions.

It's a very strange bug. Not sure what to say about it.

bill

