Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267170AbSLaGAl>; Tue, 31 Dec 2002 01:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267171AbSLaGAl>; Tue, 31 Dec 2002 01:00:41 -0500
Received: from packet.digeo.com ([12.110.80.53]:29845 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267170AbSLaGAl>;
	Tue, 31 Dec 2002 01:00:41 -0500
Message-ID: <3E11347B.2C8195D1@digeo.com>
Date: Mon, 30 Dec 2002 22:08:59 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] vm swappiness with contest
References: <200212271646.01487.conman@kolivas.net> <200212272100.44345.conman@kolivas.net> <200212281716.50535.conman@kolivas.net> <200212311658.53118.conman@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Dec 2002 06:08:59.0792 (UTC) FILETIME=[1C19A900:01C2B093]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Saturday 28 Dec 2002 5:16 pm, Con Kolivas wrote:
> > Is there something about the filesystem layer or elsewhere in the kernel
> > that could decay or fragment over time that only a reboot can fix? This
> > would seem to be a bad thing.
> 
> Ok Linus suggested I check slabinfo before and after.
> 
> I ran contest for a few days till I recreated the problem and it did recur. I
> don't know how to interpret the information so I'll just dump it here:
> 


Looks OK.  Could we see /proc/meminfo and /proc/vmstat?

What filesystem are you using?  And what kernel?
