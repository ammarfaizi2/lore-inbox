Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262720AbVAVOGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbVAVOGq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 09:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262722AbVAVOGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 09:06:46 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:49836 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S262721AbVAVOGe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 09:06:34 -0500
Message-Id: <200501221406.j0ME6SIF019928@localhost.localdomain>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
cc: "Jack O'Quin" <joq@io.com>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling 
In-reply-to: Your message of "Fri, 21 Jan 2005 08:59:52 +1100."
             <16880.10712.159729.934973@wombat.chubb.wattle.id.au> 
Date: Sat, 22 Jan 2005 09:06:28 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [151.197.206.140] at Sat, 22 Jan 2005 08:06:32 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>>> "Jack" == Jack O'Quin <joq@io.com> writes:
>
>
>Jack> Looks like we need to do another study to determine which
>Jack> filesystem works best for multi-track audio recording and
>Jack> playback.  XFS looks promising, but only if they get the latency
>Jack> right.  Any experience with that?  
>
>The nice thing about audio/video and XFS is that if you know ahead of
>time the max size of a file (and you usually do -- because you know
>ahead of time how long a take is going to be) you can precreadte the
>file as a contiguous chunk, then just fill it in, for minimum disc
>latency.

I don't know what world you're in, but this simply isn't the case in
my experience - you generally have absolutely no idea how long a take
is going to be.

--p
