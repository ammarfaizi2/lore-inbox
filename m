Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261271AbTCNWtY>; Fri, 14 Mar 2003 17:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261273AbTCNWtY>; Fri, 14 Mar 2003 17:49:24 -0500
Received: from [67.104.22.119] ([67.104.22.119]:36040 "EHLO
	skull.piratehaven.org") by vger.kernel.org with ESMTP
	id <S261271AbTCNWtX>; Fri, 14 Mar 2003 17:49:23 -0500
Date: Fri, 14 Mar 2003 15:12:27 -0800
From: Dale Harris <rodmur@maybe.org>
To: linux-kernel@vger.kernel.org
Subject: dual AMD MP 2000+ and ASUS A7M266-D problems
Message-ID: <20030314231227.GA19468@maybe.org>
Mail-Followup-To: Dale Harris <rodmur@maybe.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a small cluster of systems with:

dual AMD MP 2000+
ASUS A7M266-D motherboard
2GB RAM... DIMMs are Crucial 512MB, DDR, 266Mhz, CL2.5, ECC
I'm running 2.4.20 (Debian, or vanilla, didn't seem to matter)

The only stable configuration I can seem to get is 1 CPU and 1 DIMM.
Every other setup Cerberus just blows up in anywhere from 10 minutes to
a little over 2 hrs.  Sometimes I see an oops, other times it just stops
dead and no interrupts are handled (caps lock doesn't turn on the little
light on the keyboard).  I saw a similar conversations in the archive
about a setup similar to this and various solutions, one being to
underclock the CPUs, suggesting, I guess that CPU heat is a problem
(even though I never see an alarm out of lm_sensors).  I did update the
board to the latest BIOS (1009), that doesn't seem to have any effect.  

testing with Cerberus:

1 CPU/ 1 DIMM run all the time
2 CPU/ 1 DIMM might run for 3 hours
1 or 2 CPU with more than 1 DIMM, lucky to last 20 minutes, usually
less.

I have tried each of the four DIMMs individually, they all appear to be
fine.  

So I'm wondering if anyone has any insight into what the problem might
be.  Is underclocking the chips all I can do?


-- 
Dale Harris   
rodmur@maybe.org
/.-)
