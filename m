Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262425AbTAYW3k>; Sat, 25 Jan 2003 17:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262446AbTAYW3k>; Sat, 25 Jan 2003 17:29:40 -0500
Received: from hughes-fe01.direcway.com ([66.82.20.91]:63417 "EHLO
	hughes-fe01.direcway.com") by vger.kernel.org with ESMTP
	id <S262425AbTAYW3j>; Sat, 25 Jan 2003 17:29:39 -0500
Subject: 2.5.59-mm5 hangs on boot
From: Tom Sightler <ttsig@tuxyturvy.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Jan 2003 17:38:41 -0500
Message-Id: <1043534331.1672.71.camel@iso-2146-l1.zeusinc.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After much effort I finally managed to get my Dell Latitude C810 to boot
a 2.5.x kernel and have been happily running 2.5.59-mm2 on my RedHat 8.0
system for the last few days with very good results.  There are a few
small bugs mostly relating to unpluging of things like my USB mouse and
my Aironet wireless adapter but overall everything works great (I'll
report the other bugs in another mail).

I was interested in testing the new IO scheduler in 2.5.59-mm5 because
it attempts to correct a problem that has always bothered me but with
this kernel (using the identical config to -mm2) my system hangs almost
immediately after boot.  It happens only a few steps into the rc.sysinit
and I have been attempting to determine the exact location with some
print statements but it seems to be a slightly different times so I'm
not sure it's any particular command or step that is causing it.

My kernel is pretty basic and does not currently have ACPI, APM,
preemption, or local APIC support enabled (these have proven to be
troublesome in the past).   

This mail is basically a query to see if there is anything obviously
different between -mm2 and -mm5 that could cause this so that I could
simply back out that single patch.  At my first glance none of the
additional patches really stood out as a likely candidate for this
problem but I will continue to look in more depth.

Thanks,
Tom


