Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264008AbTE0R7S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263996AbTE0R5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:57:46 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:28934 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264050AbTE0R4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:56:42 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: manish <manish@storadinc.com>, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Date: Tue, 27 May 2003 20:01:22 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
References: <3ED2DE86.2070406@storadinc.com> <Pine.LNX.4.55L.0305271447100.756@freak.distro.conectiva> <3ED3A60E.8040405@storadinc.com>
In-Reply-To: <3ED3A60E.8040405@storadinc.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200305271958.51924.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 May 2003 19:53, manish wrote:

Hi Manish,

> With respect to the hangs that you noticed, did the processes complete
> after a "pause" or did they stay hung (deadlocked)?
yes, no processes get ever deadlocked nor anything else in this area. The 
whole system just does _nothing_ for an amount of time (1-15 seconds, 
depends). _Sometimes_ (not always) even a ping is stoped for the amount of 
time the machine does nothing but pausing.

Also not a hardware problem. I made this clear before reporting this bug. 
Tested tons of different hardware, different drivers for the network card 
etc.

I repeat this now for the $high_number'th time ;):
- 2.4.18 worked perfect
- 2.4.19-pre not

ciao, Marc


