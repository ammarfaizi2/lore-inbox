Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbSLPWys>; Mon, 16 Dec 2002 17:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261973AbSLPWys>; Mon, 16 Dec 2002 17:54:48 -0500
Received: from fmr01.intel.com ([192.55.52.18]:51431 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S261874AbSLPWyr>;
	Mon, 16 Dec 2002 17:54:47 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A5AB@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Pavel Machek'" <pavel@suse.cz>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: RE: [ACPI] Metolious hardware-sensors-using-ACPI specs
Date: Mon, 16 Dec 2002 15:02:31 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Pavel Machek [mailto:pavel@suse.cz] 
> Ouch, I started implementing that hour ago... [Never mind, very little
> damage done so far].

Wow you work fast. ;-)

> But... Metolious sounds *needed*; how do you access voltage sensors
> without metolious, in a way that can coexist with ACPI thermal
> support?

(I think you mean thermal sensors)

A solution in search of a problem. I can say this because I helped define
it. :)

The machines that care about manageability (servers) appear to be entirely
disjoint from the ones that have thermal zones (and, servers use IPMI),
therefore thermal chip contention doesn't happen. And, Metolious required a
fair amount of AML code.

-- Andy
