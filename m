Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318357AbSHUPHg>; Wed, 21 Aug 2002 11:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318358AbSHUPHg>; Wed, 21 Aug 2002 11:07:36 -0400
Received: from fairchild-196.adsl.newnet.co.uk ([213.131.187.196]:25771 "HELO
	pinus") by vger.kernel.org with SMTP id <S318357AbSHUPHf>;
	Wed, 21 Aug 2002 11:07:35 -0400
Date: Wed, 21 Aug 2002 16:10:50 +0100 (BST)
From: Steve Hill <steve@navaho.co.uk>
X-X-Sender: steve@sorbus2.navaho
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: usb-ohci preventing reboot on Cobalt Raq550
Message-ID: <Pine.LNX.4.44.0208211604350.27257-100000@sorbus2.navaho>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm having a problem with the usb-ohci module under the 2.4.18 kernel 
running on Cobalt Raq 550's - if the module is loaded then the machine 
doesn't reboot.  "shutdown -r now" shuts everything down as usual, the 
kernel displays "Restarting system." on the console, but then it just sits 
there.  If I rmmod the module before shutting down then it does exactly 
the same, but after the "Restarting system." message it does actually 
reboot.
Has anyone come across this before?  I really don't know what to look for 
in the ohci driver code that would prevent the system from rebooting, so 
any help would be appreciated.  Thanks.

-- 

- Steve Hill
System Administrator / Linux Kernel Developer    Email: steve@navaho.co.uk
Navaho Technologies Ltd.                           Tel: +44-870-7034015

        ... Alcohol and calculus don't mix - Don't drink and derive! ...



