Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267585AbTACT6x>; Fri, 3 Jan 2003 14:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267637AbTACT6x>; Fri, 3 Jan 2003 14:58:53 -0500
Received: from packet.digeo.com ([12.110.80.53]:7932 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267585AbTACT6w>;
	Fri, 3 Jan 2003 14:58:52 -0500
Message-ID: <3E15ED74.6EF0DC4A@digeo.com>
Date: Fri, 03 Jan 2003 12:07:16 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joe Korty <joe.korty@ccur.com>
CC: sct@redhat.com, adilger@clusterfs.com, rusty@rustcorp.com.au,
       riel@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre2 stalls out when running unixbench
References: <200301031656.QAA29658@rudolph.ccur.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Jan 2003 20:07:17.0019 (UTC) FILETIME=[B6D2AEB0:01C2B363]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty wrote:
> 
> Hi Everyone,
> 2.4.21-pre2 and -pre1 stall when running unixbench 4.1.0.  2.4.20
> works perfectly.

You don't have enough CPUs :)  Unpatched 2.4.20 does the same thing.

Thanks for picking this up.  Let me crunch on it a bit.
