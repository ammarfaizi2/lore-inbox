Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265738AbSKATbK>; Fri, 1 Nov 2002 14:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265739AbSKATbK>; Fri, 1 Nov 2002 14:31:10 -0500
Received: from fmr02.intel.com ([192.55.52.25]:37855 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S265738AbSKATbI>; Fri, 1 Nov 2002 14:31:08 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A498@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Jos Hulzink'" <josh@stack.nl>, Robert Varga <nite@hq.alert.sk>,
       linux-kernel@vger.kernel.org
Subject: RE: 2.5.45 build failed with ACPI turned on
Date: Fri, 1 Nov 2002 11:37:26 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jos Hulzink [mailto:josh@stack.nl] 
> After some more puzzling, it becomes clear that much more 
> ACPI code should rely on CONFIG_PM. (Sleep.c should not be 
> compiled in at all without CONFIG_PM) As the ACPI guys seem 
> awake, I assume this will be fixed soon. For now: don't 
> forget to enable CONFIG_PM (Power Management in the root of 
> ACPI / APM configuration)

ACPI implements PM but that's not all it implements. Is making CONFIG_PM
true if ACPI or APM are on a viable option? I think that would more
accurately reflect reality.

Or can we get rid of CONFIG_PM?

Regards -- Andy
