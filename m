Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263925AbTCWVkW>; Sun, 23 Mar 2003 16:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263929AbTCWVkW>; Sun, 23 Mar 2003 16:40:22 -0500
Received: from packet.digeo.com ([12.110.80.53]:15867 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263925AbTCWVkU>;
	Sun, 23 Mar 2003 16:40:20 -0500
Date: Sun, 23 Mar 2003 13:51:02 -0800
From: Andrew Morton <akpm@digeo.com>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: smp overhead, and rwlocks considered harmful
Message-Id: <20030323135102.7bd3654d.akpm@digeo.com>
In-Reply-To: <20030323214357.GA22181@vitelus.com>
References: <20030322175816.225a1f23.akpm@digeo.com>
	<20030323214357.GA22181@vitelus.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Mar 2003 21:50:51.0074 (UTC) FILETIME=[45527A20:01C2F186]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann <aaronl@vitelus.com> wrote:
>
> On Sat, Mar 22, 2003 at 05:58:16PM -0800, Andrew Morton wrote:
> > 
> > I've been looking at the CPU cost of the write() system call.  Time how long
> > it takes to write a million bytes to an ext2 file, via a million
> > one-byte-writes:
> 
> Are you using a sysenter-capable C library?

No.  That would certainly help the numbers.

But it is unrelated to the lock overhead problem.

