Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263181AbTCSWRV>; Wed, 19 Mar 2003 17:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263183AbTCSWRV>; Wed, 19 Mar 2003 17:17:21 -0500
Received: from [12.47.58.111] ([12.47.58.111]:40412 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id <S263181AbTCSWRU>; Wed, 19 Mar 2003 17:17:20 -0500
Date: Wed, 19 Mar 2003 16:33:37 -0800
From: Andrew Morton <akpm@digeo.com>
To: elenstev@mesatop.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.65-mm2
Message-Id: <20030319163337.602160d8.akpm@digeo.com>
In-Reply-To: <1048111359.1807.13.camel@spc1.esa.lanl.gov>
References: <20030319012115.466970fd.akpm@digeo.com>
	<1048103489.1962.87.camel@spc9.esa.lanl.gov>
	<20030319121055.685b9b8c.akpm@digeo.com>
	<1048107434.1743.12.camel@spc1.esa.lanl.gov>
	<1048111359.1807.13.camel@spc1.esa.lanl.gov>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Mar 2003 22:28:12.0287 (UTC) FILETIME=[D38970F0:01C2EE66]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Steven P. Cole" <elenstev@mesatop.com> wrote:
>
> > 
> > Summary: using ext3, the simple window shake and scrollbar wiggle tests
> > were much improved, but really using Evolution left much to be desired.
> 
> Replying to myself for a followup,
> 
> I repeated the tests with 2.5.65-mm2 elevator=deadline and the situation
> was similar to elevator=as.  Running dbench on ext3, the response to
> desktop switches and window wiggles was improved over running dbench on
> reiserfs, but typing in Evolution was subject to long delays with dbench
> clients greater than 16.

OK, final question before I get off my butt and find a way to reproduce this:

Does reverting

http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.65/2.5.65-mm2/broken-out/sched-2.5.64-D3.patch

help?
