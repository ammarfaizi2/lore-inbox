Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265651AbSKFPFY>; Wed, 6 Nov 2002 10:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265689AbSKFPFY>; Wed, 6 Nov 2002 10:05:24 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:19699 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S265651AbSKFPFX>; Wed, 6 Nov 2002 10:05:23 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.3.96.1021105193510.20035F-100000@gatekeeper.tmr.com> 
References: <Pine.LNX.3.96.1021105193510.20035F-100000@gatekeeper.tmr.com> 
To: Bill Davidsen <davidsen@tmr.com>
Cc: Jos Hulzink <josh@stack.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45 build failed with ACPI turned on 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Nov 2002 15:08:42 +0000
Message-ID: <26783.1036595322@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davidsen@tmr.com said:
>  More to the point, define CONFIG_PM as ( CONFIG_APM | CONFIG_ACPI )
> and be able to easily handle any new PM method on whatever hardware.
> PM is not limited to Intel hardware. Make a new HAS_PM if reusing
> CONFIG_PM creates problems.

Er, there's no reason why PM even on Intel hardware should be restricted to
ACPI and APM. With appropriate chipset documentation there's nothing to stop
people from writing proper driver code to enter sleep states, etc. for i386 
chipsets just as we have for other architectures.

--
dwmw2


