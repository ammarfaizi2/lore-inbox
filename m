Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbUDWW7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUDWW7Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 18:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUDWW7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 18:59:24 -0400
Received: from fmr05.intel.com ([134.134.136.6]:55960 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261628AbUDWW7X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 18:59:23 -0400
From: Mark Gross <mgross@linux.jf.intel.com>
Organization: Intel
To: ganzinger@mvista.com, George Anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] New high resolution time patch for 2.6.5 kernel
Date: Fri, 23 Apr 2004 15:58:42 -0700
User-Agent: KMail/1.5.4
References: <4085D096.2060103@mvista.com>
In-Reply-To: <4085D096.2060103@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404231558.42994.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 April 2004 18:38, George Anzinger wrote:
> The High Resolution Timers patch for the 2.6.5 kernel has just been posted
> on sourceforge.
>
> This patch provides an extension to the POSIX clocks and timers to define
> two new high resolution clocks (CLOCK_REALTIME_HR and CLOCK_MONOTONIC_HR). 
> The resolution of these clocks can be set at CONFIGURE time, with the
> default being 10 micro seconds.  The high res clocks can be used with
> clock_nanosleep() as well as with the POSIX timers.
>
> This version uses apic timers to obtain much better accuracy and
> simplicity.

Wow! for my systems this works really well!  The jitter is significantly reduced.  It would 
be cool if this could find its way into a major developmet tree.

--mgross

