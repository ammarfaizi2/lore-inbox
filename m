Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288351AbSAHVRg>; Tue, 8 Jan 2002 16:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288364AbSAHVR1>; Tue, 8 Jan 2002 16:17:27 -0500
Received: from zero.tech9.net ([209.61.188.187]:39944 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288351AbSAHVRQ>;
	Tue, 8 Jan 2002 16:17:16 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Andrew Morton <akpm@zip.com.au>, Anton Blanchard <anton@samba.org>,
        Andrea Arcangeli <andrea@suse.de>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <E16O2hc-0000B3-00@starship.berlin>
In-Reply-To: <20020108030420Z287595-13997+1799@vger.kernel.org>
	<E16Nxjg-00009W-00@starship.berlin> <3C3B4CB7.FEAAF5FC@zip.com.au> 
	<E16O2hc-0000B3-00@starship.berlin>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 08 Jan 2002 16:19:04 -0500
Message-Id: <1010524746.3225.112.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-08 at 15:18, Daniel Phillips wrote:

> > Instead, a decision needs to be made: "Linux will henceforth be a 
> > low-latency kernel".
> 
> I thought the intention was to make it a config option?

It was originally, it is now, and I intend it to be.

Further, since it uses the existing SMP locks, it doesn't introduce new
design decisions (the one being protection of implicitly locked per-CPU
data on preempt).

	Robert Love

