Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262423AbRE2X2S>; Tue, 29 May 2001 19:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262436AbRE2X2I>; Tue, 29 May 2001 19:28:08 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:52238 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262423AbRE2X2D>; Tue, 29 May 2001 19:28:03 -0400
Subject: Re: Hard lockup debugging suggestions?  APIC enabling suggestions?
To: shag-linux-kernel@booyaka.com (Paul Walmsley)
Date: Wed, 30 May 2001 00:25:58 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0105291807560.20712-300000@utopia.booyaka.com> from "Paul Walmsley" at May 29, 2001 06:22:57 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E154ssA-000550-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hard several times per day under Linux 2.4.4-ac11.  This lockup occurs
> during standard use of the system, e.g., web browsing or text editing.
> (What's particularly strange about the lockup is that sometimes the system
> will turn off the LCD backlight when it freezes -- but not the LCD panel
> itself.  Other times, it freezes with the backlight on.)

First things to try: Can you make it die without X, can you make it die if
you compile without APM or ACPI support.

