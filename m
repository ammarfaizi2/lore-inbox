Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266297AbSLWCm3>; Sun, 22 Dec 2002 21:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266308AbSLWCm3>; Sun, 22 Dec 2002 21:42:29 -0500
Received: from ns.netrox.net ([64.118.231.130]:62872 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S266297AbSLWCm3>;
	Sun, 22 Dec 2002 21:42:29 -0500
Subject: Re: [BENCHMARK] scheduler tunables with contest - starvation_limit
From: Robert Love <rml@tech9.net>
To: Con Kolivas <conman@kolivas.net>
Cc: David Lang <david.lang@digitalinsight.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200212231241.01049.conman@kolivas.net>
References: <Pine.LNX.4.44.0212221703070.10806-100000@dlang.diginsite.com>
	 <200212231241.01049.conman@kolivas.net>
Content-Type: text/plain
Organization: 
Message-Id: <1040611954.2129.67.camel@icbm>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 22 Dec 2002 21:52:35 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-22 at 20:40, Con Kolivas wrote:

> The current osdl hardware uses ext3 in the default journalling mode. Trying 
> different filesystems is something I have had planned for a while. When I get 
> the hardware sorted out as I need it to do this I will post some results 
> where comparisons can be made.

One thing I have found in doing low-latency research is the impact of
ext3 over ext2.  There is a periodic blip of high latency with ext3 not
seen in ext2.  Presumably due to the journal writeback of ext3.

It was not huge but a measurable increase.  This was on 2.4, so I am
curious how improved it is on 2.5.

	Robert Love

