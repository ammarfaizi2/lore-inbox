Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318346AbSGRWFh>; Thu, 18 Jul 2002 18:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318358AbSGRWFh>; Thu, 18 Jul 2002 18:05:37 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:47573 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318346AbSGRWFh>; Thu, 18 Jul 2002 18:05:37 -0400
Date: Fri, 19 Jul 2002 00:08:30 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Robert Love <rml@tech9.net>
cc: linux-kernel@vger.kernel.org, <alan@redhat.com>
Subject: Re: [PATCH] strict VM overcommit
In-Reply-To: <1026426511.1244.321.camel@sinai>
Message-ID: <Pine.NEB.4.44.0207182359300.17300-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Jul 2002, Robert Love wrote:

>...
> In the strictest of modes, it should be impossible to allocate more
> memory than available and impossible to OOM.  All memory failures should
> be pushed down to the allocation routines -- malloc, mmap, etc.
>...

Out of interest:

How is assured that it's impossible to OOM when the amount of memory
shrinks?

IOW:
- allocate very much memory
- "swapoff -a"

> Enjoy,
>
> 	Robert Love

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox




