Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289340AbSA1Tby>; Mon, 28 Jan 2002 14:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289339AbSA1Tbp>; Mon, 28 Jan 2002 14:31:45 -0500
Received: from saturno.fis.uc.pt ([193.136.215.208]:54285 "EHLO
	saturno.fis.uc.pt") by vger.kernel.org with ESMTP
	id <S289340AbSA1Tbe>; Mon, 28 Jan 2002 14:31:34 -0500
Date: Mon, 28 Jan 2002 19:31:31 GMT
From: Luis Miguel Tavora <lmtavora@saturno.fis.uc.pt>
Message-Id: <200201281931.TAA87220@saturno.fis.uc.pt>
To: linux-kernel@vger.kernel.org
Reply-To: lmtavora@saturno.fis.uc.pt
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP3 Imap webMail Program 2.0.11
X-Originating-IP: 193.137.239.227
Subject: apm and (usb) mouse confilct
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been circulating this message on different
linux groups but had no luck so far...


-------------------------------------------------------
Dear all,   

I have just updated my Toshiba 4600 laptop to 
RedHat7.2. Had some problems to get Xfree4.1 working
on the CyberBlade XP graphics card, but managed to
get around it. 

However now I've noticed that the  laptop has a
problem with apm. If the computer is  put to rest 
(apm -s) with the (logitech) usb  mouse plugged in, 
the  PC doesn't recover at all,  going into a 
reboot sequence. If the mouse is  unplugged before 
"apm -s", everything goes  well... 

No problem as  well if the mouse is connected to 
the PS2 port. 

This happens executing "apm -s" from both console 
and X mode. The mouse I'm using is a logitech 
cordless device with usb uchi interface. 

I belive  RH7.2 comes with apm 3.0final-34. I had no
problems with RH7.1, wich had version 3.0final-29 of apm. 

I tried this older version on RH7.2 but still had no luck... 

Different kernels were considered, namely 2.4.7-10,
as well as 2.4.9-13 and 2.4.17 recompiled by
myself. 

I believe that there might be a conflict with the 
hotplug utility, cause if I disable it then the laptop recovers well with the usb mouse plugged 
in... However hotplug is really needed, for 
example, to get the PCMCIA card working properly. 

Has anybody out there had any problems like this?

Any suggestions? 

Thx in advance. 

Luis
-------------------------------------------------------



PS- Please CC replies to lmtavora@saturno.fis.uc.pt
as I was not able to subscribe to the list

-----------------------------------------------------
This mail sent through IMP: http://web.horde.org/imp/
