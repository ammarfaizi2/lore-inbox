Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264042AbTE0SIB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 14:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264010AbTE0SG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 14:06:26 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:5778 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264045AbTE0SFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 14:05:33 -0400
Date: Tue, 27 May 2003 15:16:47 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: manish <manish@storadinc.com>, linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
In-Reply-To: <200305271958.51924.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.55L.0305271516220.756@freak.distro.conectiva>
References: <3ED2DE86.2070406@storadinc.com> <Pine.LNX.4.55L.0305271447100.756@freak.distro.conectiva>
 <3ED3A60E.8040405@storadinc.com> <200305271958.51924.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 May 2003, Marc-Christian Petersen wrote:

> On Tuesday 27 May 2003 19:53, manish wrote:
>
> Hi Manish,
>
> > With respect to the hangs that you noticed, did the processes complete
> > after a "pause" or did they stay hung (deadlocked)?
> yes, no processes get ever deadlocked nor anything else in this area. The
> whole system just does _nothing_ for an amount of time (1-15 seconds,
> depends). _Sometimes_ (not always) even a ping is stoped for the amount of
> time the machine does nothing but pausing.
>
> Also not a hardware problem. I made this clear before reporting this bug.
> Tested tons of different hardware, different drivers for the network card
> etc.
>
> I repeat this now for the $high_number'th time ;):
> - 2.4.18 worked perfect
> - 2.4.19-pre not

Thats very useful information. Can you track down which -pre introduced
the hangs?

Thanks!
