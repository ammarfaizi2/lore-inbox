Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279418AbRLQNys>; Mon, 17 Dec 2001 08:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279778AbRLQNyj>; Mon, 17 Dec 2001 08:54:39 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:18962 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S279418AbRLQNy2>; Mon, 17 Dec 2001 08:54:28 -0500
Message-ID: <3C1DF9AD.1DFEB1B@loewe-komp.de>
Date: Mon, 17 Dec 2001 14:57:01 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.78 [de] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: simon@baydel.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Panic output
In-Reply-To: <3C1DC16F.19499.A8A87F@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

simon@baydel.com schrieb:
> 
> During writing a driver for a PCI board I experienced the hardware
> hanging and I had to press the big red button. The hang was traced
> using a PCI analyzer and I found that the driver, loaded as a
> module, was taking a route which called panic. I changed
> /proc/sys/kernel/panic to a non zero value and the machine started
> to reboot on PCI hang. My problem is I never see any output on the
> screen or in /var/log/messages. All the stuff I have looked at in
> /usr/src/linux/Documentation suggests the messages should be
> here. I am running a 2.4.0 kernel with a SuSE 7.1 installation. At
> the hang time the system is running kde 2 and in a command
> winow I have a tail -f /var/log/messages running. The first change I
> see is the PC bios startup.
> 

First: try to start your driver from the console.
There you should see the panic message.

Then look at Documentation/serial-console.txt and hook up a serial 
console to your box
