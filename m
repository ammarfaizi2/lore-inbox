Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264081AbRFGAfT>; Wed, 6 Jun 2001 20:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264072AbRFGAfK>; Wed, 6 Jun 2001 20:35:10 -0400
Received: from femail3.rdc1.on.home.com ([24.2.9.90]:30183 "EHLO
	femail3.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S264064AbRFGAe4>; Wed, 6 Jun 2001 20:34:56 -0400
Date: Wed, 6 Jun 2001 20:34:49 -0400 (EDT)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Derek Glidden <dglidden@illusionary.com>
cc: Bill Pringlemeir <bpringle@sympatico.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <3B1E401A.CC0598D1@illusionary.com>
Message-ID: <Pine.LNX.4.33.0106062032390.26171-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
X-Spam-To: uce@ftc.gov
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2001, Derek Glidden wrote:

>>  Derek> overwhelmed.  On the system I'm using to write this, with
>>  Derek> 512MB of RAM and 512MB of swap, I run two copies of this
>>
>> Please see the following message on the kernel mailing list,
>>
>> 3086:Linus 2.4.0 notes are quite clear that you need at least twice RAM of swap
>> Message-Id: <E155bG5-0008AX-00@the-village.bc.nu>
>
>Yes, I'm aware of this.
>
>However, I still believe that my original problem report is a BUG.  No
>matter how much swap I have, or don't have, and how much is or isn't
>being used, running "swapoff" and forcing the VM subsystem to reclaim
>unused swap should NOT cause my machine to feign death for several
>minutes.
>
>I can easily take 256MB out of this machine, and then I *will* have
>twice as much swap as RAM and I can still cause the exact same
>behaviour.
>
>It's a bug, and no number of times saying "You need twice as much swap
>as RAM" will change that fact.

Precicely.  Saying 8x RAM doesn't change it either.  Sometime
next week I'm going to purposefully put a new 60Gb disk in on a
separate controller as pure swap on top of 256Mb of RAM.  My
guess is after bootup, and login, I'll have 48Gb of stuff in
swap "just in case".



----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Open Source advocate
       Opinions and viewpoints expressed are solely my own.
----------------------------------------------------------------------

