Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318806AbSHESHk>; Mon, 5 Aug 2002 14:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318812AbSHESHk>; Mon, 5 Aug 2002 14:07:40 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:47364 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S318806AbSHESHi>; Mon, 5 Aug 2002 14:07:38 -0400
Date: Mon, 5 Aug 2002 20:10:47 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-ac4
Message-ID: <20020805181047.GE25892@louise.pinerecords.com>
References: <200208051147.g75Blh720012@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208051147.g75Blh720012@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 62 days, 18 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The IDE debugging continues. -ac4 should fix the breakages in ac2/ac3. It
> hopefully also fixes the ALi hangs with non ALi north bridges (mostly 
> Transmeta boxes).

It is a nice shrubbery, but there is one small problem!!

# depmod -ae -F /boot/System.map-2.4.19-ac4 2.4.19-ac4
depmod: *** Unresolved symbols in /lib/modules/2.4.19-ac4/kernel/drivers/ide/ide-mod.o
depmod:         pci_enable_device_bars

T.
