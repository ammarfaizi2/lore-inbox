Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262080AbTCHQmX>; Sat, 8 Mar 2003 11:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262082AbTCHQmX>; Sat, 8 Mar 2003 11:42:23 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:27143 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S262080AbTCHQmX>; Sat, 8 Mar 2003 11:42:23 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303081654.h28Gskpk002027@81-2-122-30.bradfords.org.uk>
Subject: Re: what's an OOPS
To: szaka@sienet.hu (Szakacsits Szabolcs)
Date: Sat, 8 Mar 2003 16:54:46 +0000 (GMT)
Cc: ludootje@linux.be, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0303081654050.2790-100000@divine.city.tvnet.hu> from "Szakacsits Szabolcs" at Mar 08, 2003 05:01:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The number of the oops, (I.E. whether it was the first, second, third,
> > etc, starting with 0000).
> 
> Urban myth (at least on i386). The "Oops:" part can be decoded on i386 as,
> 
>  *      bit 0 == 0 means no page found, 1 means protection fault
>  *      bit 1 == 0 means read, 1 means write
>  *      bit 2 == 0 means kernel, 1 means user-mode

Interesting - I wasn't aware of that.

Maybe we should note this in Documentation/oops-tracing.txt?

Infact, overall there must be quite a lot that isn't documented at
all, except in this mailing list's archives - I think an overhaul of
Documentation/* is more than slightly overdue...

John.
