Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315544AbSECDHb>; Thu, 2 May 2002 23:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315545AbSECDHa>; Thu, 2 May 2002 23:07:30 -0400
Received: from saltbush.adelaide.edu.au ([129.127.43.5]:43413 "EHLO
	saltbush.adelaide.edu.au") by vger.kernel.org with ESMTP
	id <S315544AbSECDHa>; Thu, 2 May 2002 23:07:30 -0400
From: "Hong-Gunn Chew" <hgchewML@optusnet.com.au>
To: "'Hong-Gunn Chew'" <hgchewML@optusnet.com.au>,
        "'Petr Vandrovec'" <VANDROVE@vc.cvut.cz>,
        "'Andrea Arcangeli'" <andrea@suse.de>
Cc: "'Linux kernel mailing list'" <linux-kernel@vger.kernel.org>,
        <riel@conectiva.com.br>
Subject: RE: Memory corruption when running VMware. (was File curruption when running VMware)
Date: Fri, 3 May 2002 12:37:18 +0930
Message-ID: <002301c1f24f$a2d4ae70$241d7f81@hgclaptop>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: 
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Petr, Andrea,
> 
> I have been trying different kernel configurations to 
> overcome this problem.  I found that turning on APIC seem to 
> work properly.  However turning on IO-APIC causes it to hang 
> just after X is started, which seems to be during the startup 
> of gdm. 
An added note is that with Local APIC on and IO-APIC off, 
I am able to start the system up, but swtiching from X to a virtual
console during a session, as well as during shutdown, causes the system
to hang.  There are no error messages that I can find.
Does anyone know the cause of the problem?

Recap of my system:
CPU:		P4 2.0A 2.0GHz
RAM:		4x256MB RDRAM PC800
MB:		ASUS P4-TE firmware:1005
		Intel i850
Disk:		IBM Deskstar 120GXP 80GB
Graphics:	ATI 7500 OEM

Distri:	RedHat 7.2
Kernel:	2.4.18
X:		Xfree 4.2.0
glibc:	2.2.4-19.3

Thanks,
Hong-Gunn

