Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVALHca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVALHca (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 02:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVALHca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 02:32:30 -0500
Received: from smtp.loomes.de ([212.40.161.2]:5562 "EHLO falcon.loomes.de")
	by vger.kernel.org with ESMTP id S261254AbVALHc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 02:32:28 -0500
Subject: Re: Linux 2.6.11-rc1
From: Markus Trippelsdorf <markus@trippelsdorf.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org>
References: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org>
Content-Type: text/plain
Date: Wed, 12 Jan 2005 08:32:23 +0100
Message-Id: <1105515143.2734.6.camel@lb.loomes.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see these errors in dmesg on an AMD_64:

ACPI: Subsystem revision 20041210
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
    ACPI-1138: *** Error: Method execution failed [\MCTH] (Node
ffff81003ff8ecc0), AE_AML_BUFFER_LIMIT
    ACPI-1138: *** Error: Method execution failed [\OSFL] (Node
ffff81003ff8ed00), AE_AML_BUFFER_LIMIT
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0._S3D]
(Node ffff81003ff82140), AE_AML_BUFFER_LIMIT
    ACPI-0158: *** Error: Method execution failed [\_SB_.PCI0._S3D]
(Node ffff81003ff82140), AE_AML_BUFFER_LIMIT

But the system is running fine AFAICT.

__  
Markus

