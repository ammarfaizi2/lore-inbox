Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129321AbRB1Wrp>; Wed, 28 Feb 2001 17:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129309AbRB1Wrf>; Wed, 28 Feb 2001 17:47:35 -0500
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:49932 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S129185AbRB1WrV>; Wed, 28 Feb 2001 17:47:21 -0500
Date: Wed, 28 Feb 2001 15:47:08 -0700
From: Michal Jaegermann <michal@harddata.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Michal Jaegermann <michal@harddata.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4 kernels - "attempt to access beyond end of device"
Message-ID: <20010228154708.C30334@mail.harddata.com>
In-Reply-To: <C157EB0697@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5us
In-Reply-To: <C157EB0697@vcnet.vc.cvut.cz>; from Petr Vandrovec on Wed, Feb 28, 2001 at 10:54:15PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2001 at 10:54:15PM +0000, Petr Vandrovec wrote:
> On 28 Feb 01 at 13:46, Michal Jaegermann wrote:
> > I think that I found what gives me a hell with this box and it
> > looks like that this not Linux at all.  Once again, this is Athlon
> > K6 on Asus AV7 mobo and "Award Advanced ACPI BIOS" version 1005C.
> 
> K7 on A7V, I believe...

Maybe.  'cat /proc/cpuinfo' says "cpu family: 6" and "model :4"
(and "stepping: 2").  I possibly misinterpreted that.  Do not believe
me when I am talking about x86 chips. :-)

> > I have more checks to make before I will be fully satisfied but
> > this looks like it.
> ...
> > System Performance Setting [Optimal, Normal]
> ...
> 
> Try BIOS 1006. AFAIK 1005D changed some VIA values for 'optimal'.

Is that important here?  IDE drives in question were not connected to
on-board controller but the Promise one.  Results seem to indicate
that this 'optimal' was important here anyway.

> And 1006 contains newer Promise BIOS - but I did not notice any difference:
> Windows98 still do not boot if I connect harddisk to /dev/hdh :-(

There is at this moment Windows98 installation on /dev/hde1 and it boots
so far.   It got installed and it was booting regardless with these
"other" BIOS seetings.

> But Linux works fine...

Hope so....

  Michal
  michal@harddata.com
