Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbTAaUKl>; Fri, 31 Jan 2003 15:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262208AbTAaUKl>; Fri, 31 Jan 2003 15:10:41 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:7839 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262190AbTAaUKl>;
	Fri, 31 Jan 2003 15:10:41 -0500
Subject: Re: [RFC][PATCH] linux-2.4.21-pre4_tsc-lost-tick_A0
From: john stultz <johnstul@us.ibm.com>
To: george anzinger <george@mvista.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3E39D44A.95862534@mvista.com>
References: <1043972238.19049.27.camel@w-jstultz2.beaverton.ibm.com>
	 <3E39CC85.D9A339D0@mvista.com>
	 <1043976173.19558.12.camel@w-jstultz2.beaverton.ibm.com>
	 <3E39D44A.95862534@mvista.com>
Content-Type: text/plain
Organization: 
Message-Id: <1044044383.19552.31.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 31 Jan 2003 12:19:43 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-30 at 17:41, george anzinger wrote:
> know if he is finished as yet, but...  The jiffies update
> was part of the core patch to do the high res timers which
> he said he would not take.  I would like to try parting it
> out and pushing in some stuff, such as scmath.h which makes
> things like fast_gettimeoffset_quotient not only
> understandable but easy.  Folks in the cpu frequency area
> would like that.  Still, my boss has other plans...

Yea, I believe I commented a while back that there are some really good
generic cleanups in the high-res code. Add me to the list of folks who
would still like to see those broken out and submitted. :)

thanks
-john


