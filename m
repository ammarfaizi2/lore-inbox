Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264476AbTGGUxR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 16:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbTGGUxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 16:53:16 -0400
Received: from hermes.cicese.mx ([158.97.1.34]:52186 "EHLO hermes.cicese.mx")
	by vger.kernel.org with ESMTP id S264476AbTGGUxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 16:53:03 -0400
Message-ID: <3F09E110.78A3D89E@cicese.mx>
Date: Mon, 07 Jul 2003 14:07:28 -0700
From: Serguei Miridonov <mirsev@cicese.mx>
Reply-To: mirsev@cicese.mx
Organization: CICESE Research Center, Ensenada, B.C., Mexico
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: ru, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: diemumiee@gmx.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ATI IGP Support and System Freeze when running hwclock
References: <20030706144114.GA23881@durix.hallo.net>
		 <1057513936.1029.5.camel@dhcp22.swansea.linux.org.uk>
		 <20030706232315.GA32461@durix.hallo.net> <1057560242.2412.3.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> On Llu, 2003-07-07 at 00:23, diemumiee@gmx.de wrote:
> > I installed 2.4.21-ac with acpi. Acpi works great, but the whole system
> > freezes when i try to run "hwclock --adjust --localtime". The module
> > rtc.o gets loaded before the call to hwclock.
>
> Its something about ACPI combined with ALi real time clocks. Its still
> a mystery. Dropping the rtc module from the build should fix it

You may also rename /dev/rtc to /dev/rtcdevice or something else. When the
kernel is fixed, you may rename it back.

--
Serguei Miridonov


