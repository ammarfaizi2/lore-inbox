Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269593AbRHHWew>; Wed, 8 Aug 2001 18:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269598AbRHHWed>; Wed, 8 Aug 2001 18:34:33 -0400
Received: from [208.134.143.150] ([208.134.143.150]:34191 "EHLO
	mail.playnet.com") by vger.kernel.org with ESMTP id <S269593AbRHHWeP>;
	Wed, 8 Aug 2001 18:34:15 -0400
Message-ID: <041d01c1205a$5afd9c00$0b32a8c0@playnet.com>
From: "Marty Poulin" <mpoulin@playnet.com>
To: "David Ford" <david@blue-labs.org>,
        "David Lang" <david.lang@digitalinsight.com>
Cc: "Ben Ford" <ben@kalifornia.com>,
        "David Wagner" <daw@mozart.cs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108071957170.3450-100000@dlang.diginsite.com> <3B70E4C8.2020400@blue-labs.org>
Subject: Re: summary Re: encrypted swap
Date: Wed, 8 Aug 2001 17:34:58 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David Ford" <david@blue-labs.org>


> You can't guarantee much if the machine is physically compromised.  In
> the situation of wiping, you probably won't need swap immediately after
> boot so you can afford to execute a script that wipes the file/partition
> then mounts it.
>
> It's all easily accomplished in userspace.
>
> David
>

This all depends on what the circumstances are.  If you are talking about
someone being able to walk up to the machine while on and pull the memory
cards, nope we cant stop that with the OS.

That is not what we are trying to do, one of the specific scenarios was the
example of a notebook computer that either was shut off quickly or freezes.
If this notebook is stolen before the system is rebooted presto the crook
has access to everything in the swap.  All he has to do is take out the
drive and put it in another system.

The solution to that is encrypted swap.

Marty Poulin
vandal@playnet.com
Lead Programmer
Host/Client Communications
Playnet Inc./Cornered Rat Software



