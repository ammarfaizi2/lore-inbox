Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143426AbRELATw>; Fri, 11 May 2001 20:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143427AbRELATm>; Fri, 11 May 2001 20:19:42 -0400
Received: from jalon.able.es ([212.97.163.2]:1246 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S143426AbRELAT0>;
	Fri, 11 May 2001 20:19:26 -0400
Date: Sat, 12 May 2001 02:19:19 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new version of singlecopy pipe
Message-ID: <20010512021919.C1054@werewolf.able.es>
In-Reply-To: <3AFC36BA.B71FC470@colorfullife.com> <20010512020742.A1054@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010512020742.A1054@werewolf.able.es>; from jamagallon@able.es on Sat, May 12, 2001 at 02:07:42 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.12 J . A . Magallon wrote:
> 
> On 05.11 Manfred Spraul wrote:
> > 
> > Please test it.
> > The kernel space part should be ok, but I know that the
> > patch can cause deadlocks with buggy user space apps.
> > 
> 
> I tried your patch on 2.4.4-ac8, and something strange happens.
> Untarring linux-2.4.4 takes a little time, disk light flashes,
> but no files appear on the disk (just 'Makefile', as you will see below).
> Doing a separate gunzip - tar xf works fine:
> 

Quoting myself, I have tried with other tar.gz files and only the first
file gets extracted.
With a tar.bz2 file, I get:

werewolf:~/io> gtar jxf src.tar.bz2
gtar: Skipping to next header
gtar: Skipping to next header
gtar: Skipping to next header
gtar: Skipping to next header
gtar: Skipping to next header
gtar: Skipping to next header
gtar: Skipping to next header
gtar: Skipping to next header
gtar: Skipping to next header
gtar: Skipping to next header
gtar: Skipping to next header
gtar: Skipping to next header
gtar: Skipping to next header
gtar: Skipping to next header
gtar: Skipping to next header
gtar: Skipping to next header
gtar: Error exit delayed from previous errors

but all files seem to be there.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.4-ac8 #1 SMP Sat May 12 01:16:37 CEST 2001 i686

