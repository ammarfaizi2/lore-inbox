Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288724AbSADTGj>; Fri, 4 Jan 2002 14:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288726AbSADTGU>; Fri, 4 Jan 2002 14:06:20 -0500
Received: from ffke-campus-gw.mipt.ru ([194.85.82.65]:2224 "EHLO
	www.2ka.mipt.ru") by vger.kernel.org with ESMTP id <S288712AbSADTGB>;
	Fri, 4 Jan 2002 14:06:01 -0500
Date: Fri, 4 Jan 2002 22:41:08 -0500
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk, anton@samba.org
Subject: Re: [patch] O(1) scheduler, 2.4.17-A1, 2.5.2-pre7-A1.
Message-Id: <20020104224108.430d7eac.johnpol@2ka.mipt.ru>
In-Reply-To: <Pine.LNX.4.33.0201041743050.8766-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0201041743050.8766-100000@localhost.localdomain>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002 18:05:23 +0100 (CET)
Ingo Molnar <mingo@elte.hu> wrote:

> 
> this is the next release of the O(1) scheduler:
> 
> 	http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-A1.patch
> 	http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-A1.patch
> 
> this release includes fixes and small improvements. (The 2.5.2-A1 patch
is
> against the 2.5.2-pre7 kernel.) I cannot reproduce any more failures
with
> this patch, but i couldnt test the vfat lockup problem. The X lockup
> problem never occured on any of my boxes, but it might be fixed by one
of
> the changes included in this patch nevertheless.

Nop. System hangs after couple of minutes in X mode... :(
vfat is compiled into the 2.4.17 vanilla-kernel.
Non smp i386 but with smp kernel.
Any other info?

> 
> 	Ingo

---
WBR. //s0mbre
