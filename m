Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264854AbSKSKAk>; Tue, 19 Nov 2002 05:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264867AbSKSKAk>; Tue, 19 Nov 2002 05:00:40 -0500
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:12215 "EHLO
	dexter.hensema.net") by vger.kernel.org with ESMTP
	id <S264854AbSKSKAj>; Tue, 19 Nov 2002 05:00:39 -0500
From: Erik Hensema <usenet@hensema.xs4all.nl>
Subject: Re: APIC? IO-APIC? (was Re: 2.4.xx: 8139 isn't working)
Date: Tue, 19 Nov 2002 10:07:39 +0000 (UTC)
Message-ID: <slrnatk3bb.198.usenet@bender.home.hensema.net>
References: <20021118105631.GA27595@poup.poupinou.org> <20021119032700.81890.qmail@web12903.mail.yahoo.com>
Reply-To: erik@hensema.xs4all.nl
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dee jay (deejay2shoes@yahoo.com.au) wrote:
> 
> Hi, if i may interject at this point in time, and ask something
> related, is there any reason why we should enable APIC or IO-APIC on a
> uniprocessor system? What's the difference between the 2, or what's the
> practical usage of these?
> 
> 
> I'm reading the Configure.help and Documentation/i386/IO-APIC.txt for
> these 2 items and i'm confused.

The APIC is integrated into the CPU, the IO-APIC is part of the chipset on
your motherbord. It enabled you to use more IRQ's and therefore you need to
share less IRQ's between devices, which gives you a slight performance
benifit.

-- 
Erik Hensema (erik@hensema.net)
