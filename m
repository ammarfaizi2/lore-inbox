Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266810AbTBCQBz>; Mon, 3 Feb 2003 11:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266840AbTBCQBy>; Mon, 3 Feb 2003 11:01:54 -0500
Received: from [81.2.122.30] ([81.2.122.30]:63238 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266810AbTBCQBy>;
	Mon, 3 Feb 2003 11:01:54 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302031611.h13GBl9D019119@darkstar.example.net>
Subject: Re: problems achieving decent throughput with latency.
To: cfriesen@nortelnetworks.com (Chris Friesen)
Date: Mon, 3 Feb 2003 16:11:46 +0000 (GMT)
Cc: davem@redhat.com, ahu@ds9a.nl, greearb@candelatech.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <3E3E8CAC.7010807@nortelnetworks.com> from "Chris Friesen" at Feb 03, 2003 10:37:16 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > TCP can only send into a pipe as fast as it can see the
> > ACKs coming back.  That is how TCP clocks its sending rate,
> > and latency thus affects that.
> 
> Wouldn't you just need larger windows?  The problem is latency, not 
> bandwidth.

Exactly - the original post says that no problems are experienced
using UDP, which backs that up.

John.
