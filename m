Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318641AbSIFO3G>; Fri, 6 Sep 2002 10:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318643AbSIFO3F>; Fri, 6 Sep 2002 10:29:05 -0400
Received: from LIGHT-BRIGADE.MIT.EDU ([18.244.1.25]:9478 "HELO
	light-brigade.mit.edu") by vger.kernel.org with SMTP
	id <S318641AbSIFO3F>; Fri, 6 Sep 2002 10:29:05 -0400
Date: Fri, 6 Sep 2002 10:33:43 -0400
From: Gerald Britton <gbritton@alum.mit.edu>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre5-ac3
Message-ID: <20020906103343.A19677@light-brigade.mit.edu>
References: <200209051544.g85Fi6i09215@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200209051544.g85Fi6i09215@devserv.devel.redhat.com>; from alan@redhat.com on Thu, Sep 05, 2002 at 11:44:06AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpufreq for Speedstep seems to have broken since -ac1.  On my Mobile P3, the
boot message appears to identify my cpu clock speeds properly and displays
them:

CPU clock: 731.500 MHz (731.500-1130.500 MHz)

but the files in /proc display like this:

speed: 0
speed-min: 1104151299
speed-max: 0
speed-sync: 1

And any attempt to set the speed results in an Oops (divide by zero in
time_cpufreq_notifier).

				-- Gerald

