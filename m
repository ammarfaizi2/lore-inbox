Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279105AbRLHMWF>; Sat, 8 Dec 2001 07:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279261AbRLHMVz>; Sat, 8 Dec 2001 07:21:55 -0500
Received: from alpha.zimage.com ([216.86.199.2]:25355 "HELO alpha.zimage.com")
	by vger.kernel.org with SMTP id <S279105AbRLHMVs>;
	Sat, 8 Dec 2001 07:21:48 -0500
To: <linux-kernel@vger.kernel.org>
From: Jeff Gustafson <method@zimage.com>
Reply-To: Jeff Gustafson <ncjeffgus@zimage.com>
Subject: SMP 440GX+ hang on boot (2.4.16)
Message-Id: <20011208122147.C62182F055@alpha.zimage.com>
Date: Sat,  8 Dec 2001 04:21:47 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Apparently this is a known problem.  On this mother board we have a
AIC7xxx controller.  We also have a DAC960.  When the system tries to mount
the drives on the DAC960 (nothing is connected to the AIC7xxx), the system
hangs.  Supposedly the problem is only with UP kernels, but we get hangs 
with a SMP compiled kernel!
	The funny thing is that the kernels from RH 7.2 (2.4.7-10) and Alan
Cox's latest (2.4.13-ac8) work just fine.  The 2.4.16 kernel does not 
work.  Is there a possiblity that the fix could posted to linux-kernel?  
Maybe it could be put into the upcoming 2.4.17 release.  Please??
	Note that if you search the RedHat Bugilla site for "440GX+" you'll 
find references to this problem.

				...Jeff
