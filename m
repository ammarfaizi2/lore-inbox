Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbWARSaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbWARSaH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 13:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbWARSaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 13:30:07 -0500
Received: from quechua.inka.de ([193.197.184.2]:27852 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1030240AbWARSaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 13:30:06 -0500
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: interrupt routing ATi RS480M (MSI Megabook S270)
To: linux-kernel@vger.kernel.org,
       =?UTF-8?B?UmVuw6k=?= Rebe <rene@exactcode.de>
Date: Wed, 18 Jan 2006 19:14:15 +0100
References: <200601161607.24209.rene@exactcode.de>
User-Agent: KNode/0.10
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8Bit
Message-Id: <20060118181421.11B0F21615@dungeon.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check your bios revision. I had an irq routing issue too,
till I updated to the latest BIOS version. Now both 2.6.14 plain
and 2.6.15 ubuntu are fine, while 2.6.15 plain still gives me 
some error (happends when acpi is loaded and whole sysfs is scanned).

irqpoll option never had any effect for me, neither before nor
after the bios update, neither on 2.6.14 plain, 15 plain or
15 ubuntu.

I'm using noapictimer option to keep the clock running at normal
speed. without it runs at twice the normal speed.

btw: what are you using for graphics?
with (k)ubuntu breezy / xorg 6.8 the ati proprietory fglrx was
flickering a lot. So I updated to (k)ubuntu dapper / x.org 6.9
and tried both the open source radeon and the fglrx, but both
are very unstable, writing emails in kontakt kills them often.

so now I'm using vesa x11 driver which is terrible slow (too slow
for playing movies) and uses 1024x768 while the display is 1280x800,
but at least it is stable and flickers nearly not.

Regards, Andreas

