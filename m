Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262901AbSKMVfc>; Wed, 13 Nov 2002 16:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262908AbSKMVfc>; Wed, 13 Nov 2002 16:35:32 -0500
Received: from fmr02.intel.com ([192.55.52.25]:57845 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S262901AbSKMVfb>; Wed, 13 Nov 2002 16:35:31 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A504@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Stephen Hemminger'" <shemminger@osdl.org>
Cc: acpi-devel@sourceforge.net, Kernel List <linux-kernel@vger.kernel.org>
Subject: RE: ACPI patches updated (20021111)
Date: Wed, 13 Nov 2002 13:42:21 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Stephen Hemminger [mailto:shemminger@osdl.org] 
> Will this fix problems with IRQ routing.
> On our SMP test machines, ACPI has to be disabled otherwise the SCSI
> disk controllers don't work.
> 
> This is a major pain, and ACPI should be default off until it gets
> fixed.

ACPI has not yet been adequately tested on machines with multiple IO-APICs.
More assistance in this area would be gratefully accepted. In the meantime,
"acpi=off" works pretty well to disable ACPI-related configuration problems.

Regards -- Andy
