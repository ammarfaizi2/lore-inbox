Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbSKTTBK>; Wed, 20 Nov 2002 14:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262415AbSKTTBK>; Wed, 20 Nov 2002 14:01:10 -0500
Received: from fmr01.intel.com ([192.55.52.18]:13008 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S262420AbSKTTBI>;
	Wed, 20 Nov 2002 14:01:08 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A52A@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Ducrot Bruno'" <poup@poupinou.org>, Felix Seeger <seeger@sitewaerts.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Linux 2.4.20 ACPI
Date: Wed, 20 Nov 2002 11:08:05 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ducrot Bruno [mailto:poup@poupinou.org] 
> What I mean is that the two seems to conflict.
> Compiling with sonypi but without acpi is OK, without sonypi but
> with acpi should also be OK, but the two should be not safe because
> they use the same io registers in order to ack/clean/enable the same
> interrupt.

It would be great if someone could take a look at the sonypi driver and see
what can be done to integrate it better with ACPI. ACPI includes an EC
driver, so at the minimum, sonypi should use that instead of poking the EC
itself, perhaps.

Regards -- Andy
