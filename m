Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279457AbRJ2U0x>; Mon, 29 Oct 2001 15:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279456AbRJ2U0n>; Mon, 29 Oct 2001 15:26:43 -0500
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:34779 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S279234AbRJ2U0f>; Mon, 29 Oct 2001 15:26:35 -0500
Message-ID: <3BDDBB42.C5C8C363@rextwo.freeserve.co.uk>
Date: Mon, 29 Oct 2001 20:25:38 +0000
From: Steve Parker <steve@rextwo.freeserve.co.uk>
Reply-To: steve@rextwo.freeserve.co.uk
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.13 freezes on boot
In-Reply-To: <F266tyCEyjWk9UlwaM30001198e@hotmail.com> <20011028095527.B8059@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> 
> On Sun, Oct 28, 2001 at 01:11:24PM +0000, Solid Silver Panther wrote:
> > greetings all,
> >
> >  I apologise for the somewhat vague descriptions here, but Im no
> > experienced Kernel Hacker. I'm in my 3rd month of Linux (RedHat 7.1) and was
> >
> > <snip>
> 
> What happens if you boot without any USB devices plugged in?

I found I have a similar problem with the cpia driver. With cpia support
built into the kernel, the last thing I got was

usb.c: Registered new driver cpia

and the system stopped. Note that no USB initialisation messages
appeared prior
to the final line. This occurred with and without the camera (my only
USB
device) connected.

Building the cpia support as modules and modprobing them in after the
system
has booted seems to work without any problem.

Steve

-- 
Linux kernel 2.4.13
  8:15pm  up 1 day, 14:11,  3 users,  load average: 1.08, 1.17, 1.15
