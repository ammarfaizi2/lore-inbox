Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286723AbSAEBsn>; Fri, 4 Jan 2002 20:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286734AbSAEBsd>; Fri, 4 Jan 2002 20:48:33 -0500
Received: from mail.nep.net ([12.23.44.24]:40717 "HELO nep.net")
	by vger.kernel.org with SMTP id <S286723AbSAEBsX>;
	Fri, 4 Jan 2002 20:48:23 -0500
Message-ID: <19AB8F9FA07FB0409732402B4817D75A1251D4@FILESERVER.SRF.srfarms.com>
From: "Ryan C. Bonham" <Ryan@srfarms.com>
To: Ben Greear <greearb@candelatech.com>, "Ryan C. Bonham" <Ryan@srfarms.com>
Cc: "Linux Kernel List (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: Tyan Tomcat i815T(S2080) LAN problems
Date: Fri, 4 Jan 2002 20:48:22 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben,

Just wanted to let you, and anyone else on the list who cares know that the onblard NICs on the Tyan i815T motherboard does work correctly, with the eepro100 driver. The original board i had was bad. I got the replacment in today and it works with Rehdat 7.2 Stock and Errata kernels both. I didn't have to set the MAC address for either NIC. Thanks for your help. Sorry for cluttering the list.

Ryan

> Make sure you enable the second port in the BIOS, btw.
> 
> I forget the exact syntax (I do it in c++ code, not with 
> ifconfig or ip), but
> both ifconfig and ip programs can set the mac address.  Try
> /sbin/ip link help
> 
> That should point you in the right direction...  Note that 
> MAC == Hardware-Address
> 
> Ben
