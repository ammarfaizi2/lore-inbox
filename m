Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291074AbSCOLdx>; Fri, 15 Mar 2002 06:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291251AbSCOLdn>; Fri, 15 Mar 2002 06:33:43 -0500
Received: from smtp-server2.cfl.rr.com ([65.32.2.69]:62164 "EHLO
	smtp-server2.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S291258AbSCOLd3>; Fri, 15 Mar 2002 06:33:29 -0500
Message-ID: <3C91DC2D.BBEF50F6@cfl.rr.com>
Date: Fri, 15 Mar 2002 06:34:05 -0500
From: Mark Hounschell <dmarkh@cfl.rr.com>
Reply-To: dmarkh@cfl.rr.com
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16-lcrs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: markh@compro.net
Subject: Advanced Programmable Interrupt Controller (APIC)?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a number of DELL boxes in house. The most recent a 6400 (quad p4 box). Also a couple
of dual boxes. They all lock up intermittantly when APIC is enabled. There seems to be no solid way of reproducing the
hangs they just hang randomly. With APIC disabled they do not.
The app that we have to run on these boxes requires that APIC is enabled for irq affinity.
It is a soft real-time app that cannot tollerate the jitter. It will run but interrupt latency
is unexceptable without the irq affinity set. I've read on many lists that if you have random
lockups that you should disableapic. I've also got a number of NON-DELL boxes that don't exibit this lockup. Now I've
also heard that DELL does not properly setup the APIC chip in
the bios because MS os's don't use it. Have no idea if this is true or not. We are using
vanilla kernels (2.4.16) with some process affinity patches applied. I've also noticed that
on the quad boxes (6400) that irqs 0,1,2 cannot be directed to or from a particular processor.
This is also a problem with our app. Mostly it's the lockups that occur with APIC enabled that
is our roadblock for using these nice DELL boxes for our app. Can anyone shed some light on
this. 

Thanks in advance
and regards
-- 
Mark Hounschell
dmarkh@cfl.rr.com
