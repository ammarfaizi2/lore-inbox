Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266091AbTBXJvE>; Mon, 24 Feb 2003 04:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266100AbTBXJvE>; Mon, 24 Feb 2003 04:51:04 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:10455 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266091AbTBXJvD> convert rfc822-to-8bit; Mon, 24 Feb 2003 04:51:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Mikael Starvik <mikael.starvik@axis.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: oom killer and its superior braindamage in 2.4
Date: Mon, 24 Feb 2003 10:27:51 +0100
User-Agent: KMail/1.4.3
Cc: Jonas Holmberg <jonas.holmberg@axis.com>,
       Sebastian Sjoberg <sebastian.sjoberg@axis.com>
References: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE83A@mailse01.axis.se>
In-Reply-To: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE83A@mailse01.axis.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302241026.11321.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 February 2003 10:13, Mikael Starvik wrote:

Hi Mikael,

> Does everyone agree that killing a process is always the best approach
> to resolve an OOM? If the OOM is caused by e.g. a growing tmpfs or
> memory leaks in the kernel it won't help much to kill processes that
> may respawn.
Well, I don't agree that it's always the best approach. Other bad things, you 
metioned it, can happen.

> Would it be useful if it was possible to register another oom-handler?
> Some architectures could then choose to e.g. reboot the system instead.
I'd like to see _an option_ (read: not default but an option, e.g. boot 
parameter) that will reboot the machine after $specified_time if an OOM 
killing action does not stop.

ciao, Marc


