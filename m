Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319800AbSIMV6F>; Fri, 13 Sep 2002 17:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319801AbSIMV6F>; Fri, 13 Sep 2002 17:58:05 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:20650 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S319800AbSIMV6E>; Fri, 13 Sep 2002 17:58:04 -0400
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DE63@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Matthew Wilcox'" <willy@debian.org>
Cc: "'Marc Giger'" <gigerstyle@gmx.ch>, linux-kernel@vger.kernel.org,
       acpi-devel@sourceforge.net
Subject: RE: [ACPI] RE: ACPI Status
Date: Fri, 13 Sep 2002 15:02:45 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Matthew Wilcox [mailto:willy@debian.org] 
> One thing I'm not clear about is status of support for ACPI 2.0.
> The FAQ on intel's website claims support for ACPI 1.0b only with 2.0
> "in development", but it seems rather out of date.

ACPI 2.0 introduced new objects as well as AML grammar elements.

The interpreter is ACPI 2.0 grammar compliant (modulo bugs). A separate
matter is writing the code to take advantage of new objects.

We only take advantage of some ACPI 2.0 objects currently. (Indeed, we don't
take advantage of all ACPI 1.0 objects.)

Examples of some ACPI 1.0 objects we use: thermal zones, battery, embedded
controller
Examples of some ACPI 1.0 objects we don't use (yet): device power
management, smart battery

Examples of some ACPI 2.0 objects we use: XSDT, ECDT, processor performance
state objects
Examples of some ACPI 2.0 objects we don't use (yet): _PXM, _CST, _HPP

Regards -- Andy
