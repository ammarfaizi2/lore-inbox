Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130897AbRAPSwd>; Tue, 16 Jan 2001 13:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131639AbRAPSwY>; Tue, 16 Jan 2001 13:52:24 -0500
Received: from cmr0.ash.ops.us.uu.net ([198.5.241.38]:26293 "EHLO
	cmr0.ash.ops.us.uu.net") by vger.kernel.org with ESMTP
	id <S130897AbRAPSwO>; Tue, 16 Jan 2001 13:52:14 -0500
Message-ID: <3A6498E7.2FE17BA@uu.net>
Date: Tue, 16 Jan 2001 13:54:31 -0500
From: Alex Deucher <adeucher@UU.NET>
Organization: UUNET
X-Mailer: Mozilla 4.74 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: APM, ACPI, WOL, Oh My!
In-Reply-To: <Pine.LNX.4.10.10101161336420.1529-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mark Hahn wrote:
> 
> > mode, but the have the option apm=poweroff in my lilo.conf and with the
> 
> apm=power-off.  I'm looking at modern kernels, of course (2.4+).
> power_off is a valid alternative.  at one time, the magic string
> was smp-power-off.
> 

Whoops, I should reread my emails before I hit send; the actual string I
have on my PC is apm=power-off.


> some bioses also need to be returned to real mode before that call;
> modern kernels have a config option for that.

I tried that option, but it didn't matter, smae behavior.  I also tried
most if not all of the others like enable apm at boot time etc.

> 
> > If I shutdown in linux using a vender kernel with apm that powers off
> > the machine, it powers off fine and stays off until I hit the power
> > button or I send a wake up packet.  If I shutdown and power off using
> > win98, or with the power button, the machine goes off, but will then
> > preceed to reboot with in 3-4 minutes.  This is completely repeatable.
> > Turning it off manually during the reboot will not stop this.  If I turn
> > it off manually after it turns itself on, it will continue to try and
> > reboot itself every few minutes.  they only solution is to let linux
> > boot and perform a shutdown and power off.  then it stays off.
> 
> so don't use win98 ;)

I rarely do, which is why this problem is not as annoying as it could be
:p

> 
> > AFAIK, WOL is software independant.  The only thing I can figure it that
> 
> it's certainly not.

It's not?  But you can wake your PC remote with a WOL NIC regardless of
the OS. Shutting the PC down again is another issue.


Thanks,

Alex
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
