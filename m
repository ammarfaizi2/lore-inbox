Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281061AbRKDRzu>; Sun, 4 Nov 2001 12:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281057AbRKDRzk>; Sun, 4 Nov 2001 12:55:40 -0500
Received: from mail.uhg.net ([208.128.168.19]:24334 "EHLO
	UHGEXCHANGE00.uhg.net") by vger.kernel.org with ESMTP
	id <S280970AbRKDRzb>; Sun, 4 Nov 2001 12:55:31 -0500
Date: Sun, 4 Nov 2001 11:53:26 -0600
From: "Roach, Mark R." <mrroach@uhg.net>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: asus P5A-B psaux problem
Message-ID: <20011104115326.A29987@tncorpmrr001.uhg>
In-Reply-To: <01110412085300.00772@baldrick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01110412085300.00772@baldrick>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 12:08:53PM +0100, Duncan Sands wrote:
> Are you sure the mouse is not working?  I also
> have a P5A-B, PS/2 mouse and 2.4 kernel (many
> versions).  I also get no dmesg about PS/2.  But
> the mouse works fine!  Did you tell X windows
> that you are using a PS/2 mouse?
> 
> In XF86Config (xfree86 version 4):
> 
> Section "InputDevice"
>         Identifier      "Default Mouse"
>         Driver          "mouse"
>         Option          "CorePointer"
>         Option          "Device"   "/dev/misc/psaux" # something else for you?
>         Option          "Protocol"   "PS/2"
> EndSection
> 
> I hope this helps,
> 
> Duncan.

Yes, definitely sure that X is configured correctly (it works fine when
I boot with 2.2.19) I have also tried gpm, which works fine under 2.2,
and under 2.4.8 tells me there is no such device or address, and under
2.4.13 and 2.4.13-ac7 locks my keyboard and doesn't work.

Thanks for the suggestion, though.

Mark Roach
