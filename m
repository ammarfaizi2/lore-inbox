Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264677AbSLGSyz>; Sat, 7 Dec 2002 13:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264679AbSLGSyz>; Sat, 7 Dec 2002 13:54:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18706 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264677AbSLGSyy>; Sat, 7 Dec 2002 13:54:54 -0500
Date: Sat, 7 Dec 2002 11:03:22 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Willy Tarreau <willy@w.ods.org>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, Patrick Mochel <mochel@osdl.org>,
       <linux-kernel@vger.kernel.org>, <jgarzik@pobox.com>
Subject: Re: /proc/pci deprecation?
In-Reply-To: <20021207074457.GE21070@alpha.home.local>
Message-ID: <Pine.LNX.4.44.0212071100190.2220-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



One thing that /proc/pci gives you that 'lspci' historically didn't was
the correct interrupt setup (because kernel irq routing has nothing to do
with the PCI irq config byte on most "interesting" machines).

I don't know if lspci gets that right these days, and the information does
exist in /sys, so there is certainly at least the _potential_ of dropping
/proc/pci.

			Linus

