Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261644AbSKTREc>; Wed, 20 Nov 2002 12:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261646AbSKTREc>; Wed, 20 Nov 2002 12:04:32 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:44416 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id <S261644AbSKTRE3>;
	Wed, 20 Nov 2002 12:04:29 -0500
Date: Wed, 20 Nov 2002 18:13:41 +0100
From: Kristof Sardemann <ksardem@linux01.gwdg.de>
X-Mailer: The Bat! (v1.60q) Personal
Reply-To: Kristof Sardemann <ksardem@linux01.gwdg.de>
Organization: KKI
X-Priority: 3 (Normal)
Message-ID: <651438577.20021120181341@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
CC: manfred@colorfullife.com, jgarzik@pobox.com, ja6447@albany.edu,
       DONTcwvcaSPAM@hotmail.com
Subject: Re: bug in via-rhine network-driver (transmit timed out) Final Test-results
In-Reply-To: <3DD76371.4060009@colorfullife.com>
References: <3DD76371.4060009@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for the good help - the card works really good now. =)
In the following I'll answer to all of your suggestions in this one
mail:

>Does booting with "noapic" on the kernel command line fix your problems?
Yes, it did.
(Although I don't understand why cause I have no smp-system ;-))

>Have you tried the 8139too driver?  This driver is suppose to work
>too.
No, it didn't work in my tests.

>Try the linuxfet driver found here:
>http://www.viaarena.com/?PageID=87#ethernet
I took the driver for "Red Hat Linux 7.3 VT8231/VT8233/VT8235/VT6105
Fast Ethernet Controller" (07/23/2002 Ver 0.9) and compiled it on my
SuSE-8.1 - and it worked really good :)

Additional I found out, that booting with "acpi=off" also fixed the
problem - but this might be a specific problem of the
SuSE-8.1-Kernel.

>The hang could be caused by incomplete tx underrun handling, the
>linuxfet driver resets several registers after a tx underrun.
>Could you load the driver with debug=3? For example by adding 'options
>via-rhine debug=3' into your /etc/modules.conf?
To complete the test I'll send the detailed debug-messages tomorrow.

--
Bye.
Kristof <ksardem@linux01.gwdg.de>

