Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbTLCRKv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 12:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265081AbTLCRKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 12:10:51 -0500
Received: from mra03.ex.eclipse.net.uk ([212.104.129.88]:40147 "EHLO
	mra03.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S265062AbTLCRKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 12:10:49 -0500
From: Ian Hastie <ianh@iahastie.clara.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6] Missing L2-cache after warm boot
Date: Wed, 3 Dec 2003 17:10:42 +0000
User-Agent: KMail/1.5.4
References: <87ptf8bpnd.fsf@echidna.jochen.org> <200312020300.13067.ianh@iahastie.local.net> <878ylvjqpv.fsf@echidna.jochen.org>
In-Reply-To: <878ylvjqpv.fsf@echidna.jochen.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312031710.43786.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 Dec 2003 13:26, Jochen Hein wrote:
> Ian Hastie <ianh@iahastie.clara.net> writes:
> > On Monday 01 Dec 2003 14:04, Jochen Hein wrote:
> >> I'm running 2.6.0-test11 on an older Thinkpad 390E,
> >> When booting into 2.6.0-test11 after running Windows2000 I get:
> >
> > Do any of the previous test releases show this problem?
>
> -test11 is the first release running on that machine.  My older TP600
> destroyed its WIndows 95 so I got a replacement.  Compiling a kernel
> takes an hour or two, so it is not much fun trying different kernels.

No faster machine to compile on?  Still think this isn't a kernel problem 
anyway.

> > If it's
> > via the BIOS then does that show the L2 cache as being present?
>
> The BIOS doesn't tell anything, the setup doesn't have a "cache
> enable" or "turbo" entry.

I was just hoping it would have a configuration screen shown after POST.  I 
had expected that it would show any active caches.  Doesn't seem so likely 
now though. *8/

> > My immediate thought was a BIOS problem.  IBM's web site doesn't say any
> > BIOS updates fix L2 cache related problems, but then it doesn't seem to
> > use technical descriptions like that.  It says the latest BIOS is 1.55 -
> > R01_C9.
> >
> > http://www-1.ibm.com/support/docview.wss?rs=0&uid=psg1MIGR-4F3VKB&loc=en_
> >US
>
> I'll see what BIOS I have - it is the latest.  Thanks for the hint anyway.

OK. *8)

> > Or maybe it's possible that something in MS Windows 2000 is turning off
> > the L2 cache and it isn't getting reactivated by the warm boot?
>
> Is there any way to see what Windows does here?  I only found a manual
> enable of the L2cache when using older processors.

Who knows what a Windows programme or driver might do in order to "fix" some 
problem?  I suppose it's possible that a programme like SiSoft Sandra might 
be able to tell if the L2 cache is active or not.  There is almost bound to 
be some programme that can read the appropriate configuration bits.

> > What happens when
> > you do a cold boot to Linux then reboot from there?
>
> That is fine.
>
> For now the system seems to be fine, even when starting from Win2k via
> BIOS reboot.  Hmpf.

Annoying.  Can you think of anything you might have done with Windows 2000, eg 
programme run or device used, that you haven't done when testing?

-- 
Ian.

