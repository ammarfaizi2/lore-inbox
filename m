Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265645AbSJXUHq>; Thu, 24 Oct 2002 16:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265647AbSJXUHq>; Thu, 24 Oct 2002 16:07:46 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:3332
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S265645AbSJXUHm>; Thu, 24 Oct 2002 16:07:42 -0400
Subject: Re: [CFT] faster athlon/duron memory copy implementation
From: Robert Love <rml@tech9.net>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3DB85385.6030302@wmich.edu>
References: <3DB82ABF.8030706@colorfullife.com>
	<200210242048.36859.earny@net4u.de>  <3DB85385.6030302@wmich.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 24 Oct 2002 16:13:50 -0400
Message-Id: <1035490431.1501.101.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-24 at 16:09, Ed Sweetman wrote:

> I seem to be seeing compiler optimizations come into play with the 
> numbers and not any mention of them that i've seen has been talked 
> about. That could be causing any discrepencies with predicted values. So 
> not only would we have to look at algorithms, but also the compilers and 
> what optimizations we plan on using them with.  Some do better on 
> certain compilers+flags than others. It's a mixmatch that seems to only 
> get complicated the more realistic you make it.

The majority of the program is inline assembly so I do not think
compiler is playing a huge role here.

Regardless, the numbers are all pretty uniform in saying the new no
prefetch method is superior so its a mute point.

	Robert Love

