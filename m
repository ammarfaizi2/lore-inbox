Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287862AbSBRVmA>; Mon, 18 Feb 2002 16:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287908AbSBRVlp>; Mon, 18 Feb 2002 16:41:45 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:7940 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S287874AbSBRVl1>; Mon, 18 Feb 2002 16:41:27 -0500
Date: Mon, 18 Feb 2002 22:41:17 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Tom Holroyd <tomh@po.crl.go.jp>
cc: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Unknown HZ value! (1908) Assume 1024.
In-Reply-To: <Pine.LNX.4.44.0202181705080.26361-100000@holly.crl.go.jp>
Message-ID: <Pine.LNX.4.33.0202182238420.10144-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2002, Tom Holroyd wrote:

> After about 50 days of uptime on 2.4.17 on an Alpha, I started getting
> this message from ps, et al.  The adjtimex program says:
[...]
> 50 days is about 4320000000 clock ticks (normally 1024 Hz) which is
> suspiciously close to 2^32.  Perhaps something is rolling over?

I guess this is a userspace problem, where the tools just use a 32 bit 
value somewhere.
To make sure, can you post /proc/uptime and /proc/stat output? Also, is 
this uniprocessor or SMP?

Tim

