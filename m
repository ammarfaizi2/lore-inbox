Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292325AbSBUKkV>; Thu, 21 Feb 2002 05:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292323AbSBUKkK>; Thu, 21 Feb 2002 05:40:10 -0500
Received: from 89dyn169.com21.casema.net ([62.234.20.169]:3300 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S286179AbSBUKj5>; Thu, 21 Feb 2002 05:39:57 -0500
Message-Id: <200202211039.LAA21757@cave.bitwizard.nl>
Subject: Re: misdetection of pentium2 - very strange
In-Reply-To: <1014285431.3c74c477274c4@www.hoeg.home> from "peter@hoeg.com" at
 "Feb 21, 2002 05:57:11 pm"
To: peter@hoeg.com
Date: Thu, 21 Feb 2002 11:39:53 +0100 (MET)
CC: Jos Hulzink <josh@stack.nl>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

peter@hoeg.com wrote:
> > > prerelease)) #3 Thu Feb 21 19:21:37 SGT 2002
> > > Initializing CPU#0
> > > Detected 133.225 MHz processor.
> > > Calibrating delay loop... 265.42 BogoMIPS

> > It seems your CPU is actually running at 133 MHz. If I am right, the

> the compaq setup utility (bios setup program) reports a 333mhz with
> a bus speed of 66, so if something makes it enter a low-power mode
> it should be linux. but no apm/acpi support is compiled in/as
> modules.

There has been a scam where the "133" in the BIOS was replaced by
"333" and the resulting machines were sold as faster than they
actually were... 

You can count on it that with the above output, your CPU is running at
133 when Linux boots. It could be that the CPU is put in "slow" mode
if you run on the batteries. (Is it a laptop? I missed the beginning
of this thread). 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
