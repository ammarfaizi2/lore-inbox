Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129532AbRA2Skf>; Mon, 29 Jan 2001 13:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129710AbRA2SkP>; Mon, 29 Jan 2001 13:40:15 -0500
Received: from hssx-sktn-167-47.sasknet.sk.ca ([142.165.167.47]:28684 "HELO
	mail.thock.com") by vger.kernel.org with SMTP id <S129532AbRA2SkL>;
	Mon, 29 Jan 2001 13:40:11 -0500
Message-ID: <3A75B81E.DE8FB783@bigfoot.com>
Date: Mon, 29 Jan 2001 12:36:14 -0600
From: Dylan Griffiths <Dylan_G@bigfoot.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: More on the VIA KT133 chipset misbehaving in Linux
In-Reply-To: <Pine.LNX.4.10.10101290853030.26212-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:
> mine (gigabyte ga-7zm) shows NONE of these under 2.4.0 or the last
> 100 or so pre-2.4 kernels.  I have no idea what it does on obsolete kernels.

The symptoms have occured on a Gigabyte 7-ZX-1 and a 7-VX-1.  I have a bit
of a suspicion that the 250W power supplies aren't enough for it, but won't
be able to check this until after LWE.
 
> > 3) The clock drifts slowly (more so under heavy load than light load),
> > leaking time.
> 
> this is perfectly normal for all computers; it's why ntpd exists.
> I collect my ntp drifts, and they look perfectly normal (compared
> to drifts over the same period on two other linux boxes and a Sun 420R.)


This isn't 5 seconds in a month or two like my old K6-III/EPoX MVP3-G
setup.  This is 10 minutes every 9-12 hours.  When I woke up this morning,
my clock was off by 15 minutes.  That's a bit abnormal 

> > I think #2 is because e820h memory detection is not properly implemented on
> > the KT133 chipset, or because of some silly BIOS bug that VIA has not
> 
> perhaps you should upgrade your bios.

Very much so.  I'll have to wait until I can get a DOS boot disk, though,
since flashing doesn't work well in Linux ;)
 
> #1 is usually a sign that gpm/X are not talking the same mouse protocol
> as your mouse.  my board gets along swimmingly with my mouseman/fx
> (I've probably never had anything else on it.)

No GPM.  Logitech PS/2 mouse with imps2.  Microsoft Intelli PS/2 mouse does
the same.

--
    www.kuro5hin.org -- technology and culture, from the trenches.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
