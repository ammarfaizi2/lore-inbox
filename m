Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131542AbRCNV1J>; Wed, 14 Mar 2001 16:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131554AbRCNV07>; Wed, 14 Mar 2001 16:26:59 -0500
Received: from mail.valinux.com ([198.186.202.175]:47117 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S131550AbRCNV0p>;
	Wed, 14 Mar 2001 16:26:45 -0500
To: linux-kernel@vger.kernel.org
Subject: Remote Management (was Re: Alert on LAN)
X-Newsgroups: linux.kernel
In-Reply-To: <E14d8Rh-0007Xr-00@morgoth>
From: chip@valinux.com (Chip Salzenberg)
In-Reply-To: <Pine.LNX.4.10.10103131842110.19423-100000@clueserver.org>
Organization: VA Linux Systems
Cc: terje.malmedal@usit.uio.no
Message-Id: <E14dImS-0006DX-00@traeki.engr.valinux.com>
Date: Wed, 14 Mar 2001 13:26:04 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IBM says, as quoted by Terje Malmedal:
>   With the latest release, Alert on LAN 2 now extends IT
>   capabilities to remotely manage and control their
>   networked PCs:
>
>       Remote system reboot upon report of a critical failure 
>       Repair Operating System 
>       Update BIOS image 
>       Perform other diagnostic procedures 

OK, fine... but: Where are the authentication and authorization?!
Surely I'm not the only person to see in this "Alert On LAN 2" the
potential for a security disaster.  I know I will never buy anything
that supports AOL2 until its security features are openly documented
and testable.

> The feature I really need is to be able to reset the machine
> remotely when Linux is hung.

Some current PC motherboards support remote management via a serial
line.  Of course, you'll need software: The VA Cluster Manager (GPL'd
- http://sourceforge.net/projects/vacm) can monitor and control any
number of clients, limited only by the number of serial ports you can
give it.  VACM also includes optional client support for enhanced
monitoring, e.g. of temperatures.  I'm not sure which motherboards it
supports, but I'm sure you can find current documentation.  :-)

Granted, this is not cheap.  A VACM-style approach costs some money
for the monitor computer, and some convenience for installing the
serial lines; meanwhile, AOL2 promises to do it all over Ethernet.
But with VACM, you can be sure that somebody has to log in to the
monitor computer -- with security levels you control! -- before they
can control or even monitor any connected clients.

BTW, in the spirit of full disclosure: VACM is a product of VA Linux
engineering, and I work for VA.  But VACM is GPL'd and we don't charge
for it, so I have little financial interest in seeing it used.  I just
*hate* it when people play fast & loose with my security.
