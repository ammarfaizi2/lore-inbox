Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287518AbSAHA6m>; Mon, 7 Jan 2002 19:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287521AbSAHA6c>; Mon, 7 Jan 2002 19:58:32 -0500
Received: from dsl-65-185-109-125.telocity.com ([65.185.109.125]:39296 "HELO
	ohdarn.net") by vger.kernel.org with SMTP id <S287518AbSAHA6N>;
	Mon, 7 Jan 2002 19:58:13 -0500
Subject: Re: USB Lockups
From: Michael Cohen <lkml@ohdarn.net>
To: linux-kernel@vger.kernel.org
Cc: Johannes Erdfelt <johannes@erdfelt.com>
In-Reply-To: <20020107193600.S10145@sventech.com>
In-Reply-To: <1010449229.4069.6.camel@ohdarn.net> 
	<20020107193600.S10145@sventech.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 07 Jan 2002 19:58:12 -0500
Message-Id: <1010451492.4127.8.camel@ohdarn.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Tried with UHCI and JE driver. JE doesn't recognize the USB controller
> > half the time.  It seems to me that this is similar to the problem
> > with a saturated PCI bus that someone posted a latency fix for.
> > I'd appreciate any input.  A similar machine does this on windows as
> > well, too.  BIOS is as late as it gets.
> 
> Doesn't recognize the USB controller half the time? This is something I
> would expect to either work all of the time, or none of the time.
> 
> Do you get any error messages?

The JE driver strangely seems to be an unstable beast on here.
It more often does not work, though every once in a while it wakes up on
boot.  I've stuck with the standard.  As for error messages, "No devices
found" is the only one I get with the standard driver (when nothing is
plugged in :).  Oh, it's SMP PIII.

------
Michael Cohen


> JE
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


