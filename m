Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262719AbTCUBqM>; Thu, 20 Mar 2003 20:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262768AbTCUBqM>; Thu, 20 Mar 2003 20:46:12 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:40357 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S262719AbTCUBqL>;
	Thu, 20 Mar 2003 20:46:11 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Eric Wong <eric@yhbt.net>
Subject: Re: [patch] sched-2.5.64-bk10-C4
Date: Fri, 21 Mar 2003 12:57:09 +1100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0303161213200.4930-100000@localhost.localdomain> <20030321004409.GA16206@bl4st.yhbt.net>
In-Reply-To: <20030321004409.GA16206@bl4st.yhbt.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303211257.09042.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Mar 2003 11:44, Eric Wong wrote:
> Ingo Molnar <mingo@elte.hu> wrote:
> > the attached patch fixes a fundamental (and long-standing) bug in the
> > sleep-average estimator which is the root cause of the "contest
> > process_load" problems reported by Mike Galbraith and Andrew Morton, and
> > which problem is addressed by Mike's patch.
> >

> Would this be an equivalent fix for 2.4.20-ck4?

Yes it would be, but ck4 is less prone to the same problem without the other 
interactivity changes in 2.5. I'm working on putting them all together for 
-ck* but until they are semi-stabilised I wont release them.

Con
