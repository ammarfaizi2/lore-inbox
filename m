Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288174AbSCLXFk>; Tue, 12 Mar 2002 18:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288071AbSCLXFV>; Tue, 12 Mar 2002 18:05:21 -0500
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:46018 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S287862AbSCLXFL>; Tue, 12 Mar 2002 18:05:11 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7CDE@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Mario 'BitKoenig' Holbe'" <Mario.Holbe@RZ.TU-Ilmenau.DE>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: RE: [patch] ACPI: kbd-pw-on/WOL don't work anymore since 2.4.14
Date: Tue, 12 Mar 2002 15:05:04 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Mario 'BitKoenig' Holbe [mailto:Mario.Holbe@RZ.TU-Ilmenau.DE]

[explanation of problem and various code paths snipped]

> And if there can't be any, why should I'm not be able to work
> around this bug?
> And yes - I consider this as bug :) There is code, which is never
> called, afaics.

Well sure, you can work around this bug on your particular machine, but I
can't do the same because then, unlike your machine where not enough devices
are enabled for wake, *too many* devices will be enabled for wake on some
machines. This results in them not turning off properly -- they come right
back on. ;-)

So, there is a general-purpose fix for this, it just is going to take more
than deleting one line.

Regards -- Andy
