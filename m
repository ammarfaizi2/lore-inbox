Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266163AbUJLQO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUJLQO3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 12:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266128AbUJLQO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 12:14:28 -0400
Received: from aun.it.uu.se ([130.238.12.36]:43947 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266116AbUJLQLa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 12:11:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16748.558.109519.887814@alkaid.it.uu.se>
Date: Tue, 12 Oct 2004 18:11:26 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "mobil@wodkahexe.de" <mobil@wodkahexe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4 No local APIC present or hardware disabled
In-Reply-To: <20041012195448.2eaabcea.mobil@wodkahexe.de>
References: <20041012195448.2eaabcea.mobil@wodkahexe.de>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mobil@wodkahexe.de writes:
 > Hi,
 > 
 > after upgrading to 2.6.9-rc4 I'm getting the following message in dmesg:
 > 
 > No local APIC present or hardware disabled
 > 
 > 2.6.9-rc3 and older kernels did not show this message. They showed:
 >  Local APIC disabled by BIOS -- reenabling.
 >  Found and enabled local APIC!
 > 
 > Any hints ?

Boot with "lapic" to force-enable the local APIC.

Automatically overriding the BIOS was considered a bug in
some quarters (mainly ACPI), so the code was changed to
require a kernel boot option to enable the override.

BIOSen suck.
