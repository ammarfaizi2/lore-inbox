Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291212AbSBRTJJ>; Mon, 18 Feb 2002 14:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290958AbSBRTHe>; Mon, 18 Feb 2002 14:07:34 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:16120 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S290974AbSBRTFC>; Mon, 18 Feb 2002 14:05:02 -0500
Message-ID: <3C715036.EBC74D72@mvista.com>
Date: Mon, 18 Feb 2002 11:04:22 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org, "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: Missed jiffies
In-Reply-To: <3C6E77DE.70FE49DF@rwii.com> <3C6E833F.1A888B3C@mvista.com> <a4pbvi$iq2$1@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" wrote:
> 
> Followup to:  <3C6E833F.1A888B3C@mvista.com>
> By author:    george anzinger <george@mvista.com>
> In newsgroup: linux.dev.kernel
> >
> > One of the nasty problems, especially with machines such as yours (i.e.
> > lap tops), is the fact that TSC is NOT clocked at a fixed rate.  It is
> > affected by throttling (reduced in 12.5% increments) and by power
> > management.
> 
> If the TSC is affected by HLT, throttling, or C2 power management, the
> TSC is broken (as it is on Cyrix chips, for example.)  The TSC usually
> *is* affected by C3 power management, but the OS should be aware of
> C3.
> 
>         -hpa
Gosh I would LIKE to think this is true.  Could you give a reference?  I
believe Andrew Grover thinks that what I have stated is true.  If I am
wrong, it will make the high-res-timers MUCH more acceptable as the TSC
overhead is MUCH lower that the ACPI pm timer.

Do I have this right Andrew?
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
