Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263126AbTCSUAJ>; Wed, 19 Mar 2003 15:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263130AbTCSUAJ>; Wed, 19 Mar 2003 15:00:09 -0500
Received: from packet.digeo.com ([12.110.80.53]:53701 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263126AbTCSUAI>;
	Wed, 19 Mar 2003 15:00:08 -0500
Date: Wed, 19 Mar 2003 12:10:55 -0800
From: Andrew Morton <akpm@digeo.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.65-mm2
Message-Id: <20030319121055.685b9b8c.akpm@digeo.com>
In-Reply-To: <1048103489.1962.87.camel@spc9.esa.lanl.gov>
References: <20030319012115.466970fd.akpm@digeo.com>
	<1048103489.1962.87.camel@spc9.esa.lanl.gov>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Mar 2003 20:10:52.0340 (UTC) FILETIME=[A4254F40:01C2EE53]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole <elenstev@mesatop.com> wrote:
>
> On Wed, 2003-03-19 at 02:21, Andrew Morton wrote:
> > 
> > http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.65/2.5.65-mm2/
> > 
> 
> I am seeing a significant degradation of interactivity under load with
> recent -mm kernels.  The load is dbench on a reiserfs file system with
> increasing numbers of clients.  The test machine is single PIII, IDE,
> 256MB memory, all kernels PREEMPT.

(This email brought to you while running dbench 128 on ext3)

There's a pretty big reiserfs patch in -mm.  Are you able to whip up
an ext2 partition and see if that displays the same problem?

