Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbTE2RXI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 13:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbTE2RXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 13:23:08 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:39379 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262431AbTE2RXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 13:23:06 -0400
Date: Thu, 29 May 2003 10:36:28 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Downing, Thomas" <Thomas.Downing@ipc.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm2
Message-Id: <20030529103628.54d1e4a0.akpm@digeo.com>
In-Reply-To: <170EBA504C3AD511A3FE00508BB89A920221E5FF@exnanycmbx4.ipc.com>
References: <170EBA504C3AD511A3FE00508BB89A920221E5FF@exnanycmbx4.ipc.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 May 2003 17:36:24.0586 (UTC) FILETIME=[D37686A0:01C32608]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Downing, Thomas" <Thomas.Downing@ipc.com> wrote:
>
> -----Original Message-----
> From: Andrew Morton [mailto:akpm@digeo.com]
> 
> >
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-
> mm2/
> [snip]
> >  Needs lots of testing.
> [snip]
> 
> I for one would like to help in that testing, as might others.
> Could you point to/name some effective test tools/scripts/suites 
> for testing your work?  As it is, my testing is just normal usage,
> lots of builds.
> 

I was specifically referring to the O_SYNC changes there.  That means
databases: postgresql, mysql, sapdb, etc.

Some of these use fsync()-based synchronisation and won't benefit, but they
may have compile-time or runtime options to use O_SYNC instead.


Apart from that, just using the kernel in day-to-day activity is the most
important thing.  If everyone does that, and everyone is happy then by
definition this kernel is a wrap.
