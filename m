Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262689AbRFBU0V>; Sat, 2 Jun 2001 16:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262692AbRFBU0L>; Sat, 2 Jun 2001 16:26:11 -0400
Received: from host213-123-127-165.btopenworld.com ([213.123.127.165]:51724
	"EHLO argo.dyndns.org") by vger.kernel.org with ESMTP
	id <S262689AbRFBU0B>; Sat, 2 Jun 2001 16:26:01 -0400
X-test: X
To: John Cavan <johnc@damncats.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
From: lk@mailandnews.com
Subject: Re: CUV4X-D lockup on boot
In-Reply-To: <E156E44-0001sS-00@the-village.bc.nu> <3B193BE0.4B15ACEC@damncats.org>
Date: 02 Jun 2001 21:25:58 +0100
In-Reply-To: John Cavan's message of "Sat, 02 Jun 2001 15:17:52 -0400"
Message-ID: <m3snhipr1l.fsf@fork.man2.dom>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Cavan <johnc@damncats.org> writes:

> Alan Cox wrote:
> > At minimum you need the 1007 bios and to run noapic. As yet we don't know why
> > or what the newer BIOS has done to make it boot at all
> 
> Actually, I'm running this board with MPS 1.1, BIOS version 1007, and
> APIC enabled without problem. Current kernel is 2.4.5-ac5, no lockups,
> no boot failures, full access to my USB, etc.
> 
> With the older BIOS revision, you definitely need to have "noapic" as an
> option. For the latest BIOS, just ensure that you set MPS 1.4 support
> off.

Indeed, disabling MPS 1.4 does appear to solve the problem. Incidentally,
I also had to enable legacy USB support always (instead of Auto) to
allow my usb camera to work whilst in SMP mode. Is MPS 1.4 worth
having and the problem worth solving, or should I stick with this?

Paul
