Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265517AbSL1GRt>; Sat, 28 Dec 2002 01:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbSL1GRt>; Sat, 28 Dec 2002 01:17:49 -0500
Received: from packet.digeo.com ([12.110.80.53]:55766 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265517AbSL1GRt>;
	Sat, 28 Dec 2002 01:17:49 -0500
Message-ID: <3E0D43F8.90A9E683@digeo.com>
Date: Fri, 27 Dec 2002 22:26:00 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: conman@kolivas.net
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
Subject: Re: [BENCHMARK] vm swappiness with contest
References: <200212271646.01487.conman@kolivas.net> <200212272100.44345.conman@kolivas.net> <200212281716.50535.conman@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Dec 2002 06:26:01.0152 (UTC) FILETIME=[FDA39400:01C2AE39]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> ...
> Is there something about the filesystem layer or elsewhere in the kernel that
> could decay or fragment over time that only a reboot can fix? This would seem
> to be a bad thing.

Not much that I can think of.  Apart from a damn great memory leak
somewhere.

Suggest you perform a few runs, keeping an eye on the vm statistics
after each run.
