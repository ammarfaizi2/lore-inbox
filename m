Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbUBYBqR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 20:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbUBYBmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:42:53 -0500
Received: from bhhdoa.org.au ([216.17.101.199]:63753 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S262353AbUBYBi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:38:59 -0500
Message-ID: <1077674458.403c01da445ea@vds.kolivas.org>
Date: Wed, 25 Feb 2004 13:00:58 +1100
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Cc: Cliff White <cliffw@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: reaim - 2.6.3-mm1 IO performance down.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>Running the reaim 'new_fserver' workload, we now see a performance drop on
>2.6.3-mm1, ext3 filesystem

I observed a serious slowdown on non numa, non smt machines with kernbench and
the scheduler changes (posted results a week ago here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=107719112225482&w=2 )

A summary of those results is half job load (-j4 on 8x):
2.6.3: Elapsed Time 231.274
2.6.3-mm1: Elapsed Time 273.688

The drop in reaim performance is possibly related.

Con
