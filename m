Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289826AbSBSUWD>; Tue, 19 Feb 2002 15:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289823AbSBSUVy>; Tue, 19 Feb 2002 15:21:54 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:65034 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S289817AbSBSUVk>;
	Tue, 19 Feb 2002 15:21:40 -0500
Date: Tue, 19 Feb 2002 09:30:53 +0000
From: Pavel Machek <pavel@suse.cz>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Missed jiffies
Message-ID: <20020219093052.B37@toy.ucw.cz>
In-Reply-To: <3C6E77DE.70FE49DF@rwii.com> <3C6E833F.1A888B3C@mvista.com> <a4pbvi@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <a4pbvi@cesium.transmeta.com>; from hpa@zytor.com on Sun, Feb 17, 2002 at 02:48:18PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > lap tops), is the fact that TSC is NOT clocked at a fixed rate.  It is
> > affected by throttling (reduced in 12.5% increments) and by power
> > management.
> 
> If the TSC is affected by HLT, throttling, or C2 power management, the
> TSC is broken (as it is on Cyrix chips, for example.)  The TSC usually
> *is* affected by C3 power management, but the OS should be aware of
> C3.

Add thinkpad 560X (pentium/MMX) and toshiba 4030cdt (celeron) to your
blacklist, then. I believe that by your definition *many* sstems are
broken.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

