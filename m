Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278795AbRKHXYG>; Thu, 8 Nov 2001 18:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278829AbRKHXX5>; Thu, 8 Nov 2001 18:23:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8964 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278795AbRKHXXt>; Thu, 8 Nov 2001 18:23:49 -0500
Subject: Re: VIA 686 timer bugfix incomplete
To: george@mvista.com (george anzinger)
Date: Thu, 8 Nov 2001 23:30:52 +0000 (GMT)
Cc: vojtech@suse.cz (Vojtech Pavlik), diemer@gmx.de (Jonas Diemer),
        linux-kernel@vger.kernel.org
In-Reply-To: <3BEAF962.8E407C30@mvista.com> from "george anzinger" at Nov 08, 2001 01:30:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E161ydI-000178-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Me thinks the real solution is the ACPI pm timer.  3 times the
> resolution of the PIT and you can not stop it.  The high-res-timers
> patch will allow you to use this as the time keeper and just use the PIT
> to generate interrupts.

For awkward boxes you can use the PIT, for good boxes we can use rdtsc or
eventually the ACPI timers when running with ACPI
