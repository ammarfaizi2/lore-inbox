Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267748AbRGURJl>; Sat, 21 Jul 2001 13:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267751AbRGURJb>; Sat, 21 Jul 2001 13:09:31 -0400
Received: from jdi.jdimedia.nl ([212.204.192.51]:19410 "EHLO jdi.jdimedia.nl")
	by vger.kernel.org with ESMTP id <S267750AbRGURJZ>;
	Sat, 21 Jul 2001 13:09:25 -0400
Date: Sat, 21 Jul 2001 19:09:03 +0200 (CEST)
From: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
X-X-Sender: <igmar@jdi.jdimedia.nl>
To: Greg KH <greg@kroah.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.6] USB thinks I've got 2 keyboards
In-Reply-To: <20010721094511.A4830@kroah.com>
Message-ID: <Pine.LNX.4.33.0107211906470.28410-100000@jdi.jdimedia.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


> > A HP pavilion with a USB keyboard and mouse :
> >
> > Kernel : 2.4.6
>
> Can you send the result of /proc/bus/usb/devices when this device is
> plugged in?

/proc/bus/usb/ is empty here.

/proc/driver/uhci/hc0 lists :

HC status
  usbcmd    =     00c1   Maxp64 CF RS
  usbstat   =     0000
  usbint    =     000f
  usbfrnum  =   (0)3bc
  flbaseadd = 0125c3bc
  sof       =       40
  stat1     =     0095   PortEnabled PortConnected
  stat2     =     0095   PortEnabled PortConnected
Frame List
Skeleton TD's
- skel_term_td
    [c12611b0] link (012611b0) e0 Length=0 MaxLen=7ff DT0 EndPt=0 Dev=7f,
PID=69(IN) (buf=00000000)
- skel_int128_td
    [c12611e0] link (01261210) e0 IOC Active NAK Length=7ff MaxLen=0 DT0
EndPt=1 Dev=2, PID=69(IN) (buf=07f9d528)
    [c1261210] link (01261270) e0 IOC Active NAK Length=7ff MaxLen=0 DT1
EndPt=1 Dev=3, PID=69(IN) (buf=07f9d5a8)
    [c1261270] link (01261120) e0 IOC Active NAK Length=7ff MaxLen=3 DT1
EndPt=2 Dev=5, PID=69(IN) (buf=07ce0c90)
- skel_int8_td
    [c1261240] link (012612a0) e0 IOC Active NAK Length=7ff MaxLen=7 DT1
EndPt=1 Dev=5, PID=69(IN) (buf=07d36c90)
    [c12612a0] link (01261060) e0 LS IOC Active NAK Length=7ff MaxLen=7
DT0 EndPt=1 Dev=4, PID=69(IN) (buf=07d38c90)
Skeleton QH's

A recompile is not a problem here, so if you need other info..

> greg k-h


	Igmar

-- 

Igmar Palsenberg
JDI Media Solutions

Boulevard Heuvelink 102
6828 KT Arnhem
The Netherlands

mailto: i.palsenberg@jdimedia.nl
PGP/GPG key : http://www.jdimedia.nl/formulier/pgp/igmar

