Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317807AbSGVVMo>; Mon, 22 Jul 2002 17:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317808AbSGVVMn>; Mon, 22 Jul 2002 17:12:43 -0400
Received: from bdsl.66.13.29.10.gte.net ([66.13.29.10]:13184 "EHLO
	bluesong.NET") by vger.kernel.org with ESMTP id <S317807AbSGVVLu> convert rfc822-to-8bit;
	Mon, 22 Jul 2002 17:11:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Jack F. Vogel" <jfv@bluesong.net>
Reply-To: jfv@bluesong.net
To: "Craig I. Hagan" <hagan@cih.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: APIC issues with 2.4.19-rcX-acY
Date: Mon, 22 Jul 2002 14:18:13 -0700
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0207221058320.20806-100000@svr.cih.com>
In-Reply-To: <Pine.LNX.4.44.0207221058320.20806-100000@svr.cih.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207221418.13111.jfv@bluesong.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 July 2002 11:01 am, Craig I. Hagan wrote:
> I've seen the following error when booting a dell 2550 (dual p3,
> serverworks CNB20HE chipset):
>
> APIC error on CPU0: 08(08)
> (repeats until i hard reset the machine)
>
> I've seen this for every combination of 2.4.19-rc/ac patch that i've tried,
> however the 2.4.19-rc kernels work fine (my test system is currently
> running 2.4.19-rc3). I'd like to help resolve this issue, but I'm not quite
> sure as to where to start save rolling back all of the apic deltas in the
> -ac patch series.

As Alan has posted, this is a problem with code merged into rc2-ac6 and
after to support the high end IBM xSeries machines.

Its broken and myself and James Cleverdon are actively working the issue.

This is code that exists as a patch for the generic tree and works fine, but
something has gone oddly wrong here, we still havent tracked it down, but
stay tuned... 

-- 
Jack F. Vogel		IBM Linux Technology Center
jfv@us.ibm.com (work)  ||  jfv@bluesong.net (home)
