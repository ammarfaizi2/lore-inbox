Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261281AbTCTBAC>; Wed, 19 Mar 2003 20:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261264AbTCTBAC>; Wed, 19 Mar 2003 20:00:02 -0500
Received: from packet.digeo.com ([12.110.80.53]:25999 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261281AbTCTBAB>;
	Wed, 19 Mar 2003 20:00:01 -0500
Date: Wed, 19 Mar 2003 19:15:36 -0800
From: Andrew Morton <akpm@digeo.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: alexh@ihatent.com, philippe.gramoulle@mmania.com,
       linux-kernel@vger.kernel.org
Subject: Re: Hard freeze with 2.5.65-mm1
Message-Id: <20030319191536.58ea9d35.akpm@digeo.com>
In-Reply-To: <20030320010319.GB1240@holomorphy.com>
References: <20030319104927.77b9ccf9.philippe.gramoulle@mmania.com>
	<8765qfacaz.fsf@lapper.ihatent.com>
	<20030319182442.4a9fa86c.philippe.gramoulle@mmania.com>
	<877kav5ikv.fsf@lapper.ihatent.com>
	<20030319121909.74f957af.akpm@digeo.com>
	<20030320010319.GB1240@holomorphy.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Mar 2003 01:10:12.0405 (UTC) FILETIME=[752DBE50:01C2EE7D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> $ less /proc/16657/wchan
> do_clock_nanosleep

There is a bug in do_clock_nanosleep().  I can reproduce it.  I'll fix it up
later today.

