Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285013AbRLUT0W>; Fri, 21 Dec 2001 14:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285041AbRLUT0P>; Fri, 21 Dec 2001 14:26:15 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:41478 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S285014AbRLUTX7>;
	Fri, 21 Dec 2001 14:23:59 -0500
Date: Tue, 18 Dec 2001 00:21:10 +0000
From: Pavel Machek <pavel@suse.cz>
To: Kimio Suganuma <k-suganuma@mvj.biglobe.ne.jp>
Cc: linux-kernel@vger.kernel.org, large-discuss@lists.sourceforge.net,
        Heiko Carstens <Heiko.Carstens@de.ibm.com>,
        Jason McMullan <jmcmullan@linuxcare.com>,
        Anton Blanchard <antonb@au1.ibm.com>,
        Greg Kroah-Hartman <ghartman@us.ibm.com>, rusty@rustcorp.com.au
Subject: Re: [ANNOUNCE] HotPlug CPU patch against 2.5.0
Message-ID: <20011218002110.B37@toy.ucw.cz>
In-Reply-To: <20011213132557.5B3E.K-SUGANUMA@mvj.biglobe.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011213132557.5B3E.K-SUGANUMA@mvj.biglobe.ne.jp>; from k-suganuma@mvj.biglobe.ne.jp on Thu, Dec 13, 2001 at 01:29:42PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The Hotplug CPU patch for 2.5.0 is uploaded.
> 
>   http://sourceforge.net/projects/lhcs/
> 
> This patch works on s390, s390x, x86 and ia64 architectures.
> It can also be applied against 2.4.16 with a little modification.
> 
> Down CPU
> echo 0 > /proc/sys/kernel/cpu/<id>/online
> 
> Up CPU
> echo 1 > /proc/sys/kernel/cpu/<id>/online

Such patches are neccessary for ACPI S3/S4 sleep support. It would be nice to
apply them soon.
								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

