Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbTIJPeE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 11:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265031AbTIJPeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 11:34:03 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:29312 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265029AbTIJPd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 11:33:59 -0400
Date: Wed, 10 Sep 2003 16:47:04 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309101547.h8AFl4Sl002463@81-2-122-30.bradfords.org.uk>
To: davem@redhat.com, miller@techsource.com
Subject: Re: Lock EVERYTHING (for testing) [was: Re: Scaling noise]
Cc: anton@samba.org, linux-kernel@vger.kernel.org, lm@bitmover.com,
       mbligh@aracnet.com, phillips@arcor.de, piggin@cyberone.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The analogy for Linux is this:  At a machine level, we add a check to 
> EVERY access.  The check is there to ensure that every memory access is 
> properly locked.  So, if some access is made where there isn't a proper 
> lock applied, then we can print a warning with the line number or drop 
> out into kdb or something of that sort.
>
> I'm betting there's another solution to this, otherwise, I wouldn't 
> suggest such an idea, because of the relative amount of work versus 
> benefit.  But it may require massive modifications to GCC to add this 
> code in at the machine level.

Couldn't Valgrind be modified to do this for the kernel?

http://developer.kde.org/~sewardj/

John.
