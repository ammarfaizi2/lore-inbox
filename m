Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264334AbTEaOWB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 10:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264339AbTEaOWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 10:22:01 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:27616
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264334AbTEaOWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 10:22:00 -0400
Subject: Re: [2.5.70] - APIC error on CPU0: 00(40)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: rol@as2917.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200305311052.h4VAqxEM001927@harpo.it.uu.se>
References: <200305311052.h4VAqxEM001927@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054388239.27311.3.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 31 May 2003 14:37:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-05-31 at 11:52, mikpe@csd.uu.se wrote:
> Received illegal vector errors. Your boot log reveals that you're
> using ACPI and IO-APIC on a SiS chipset. Disable those and try
> again -- I wouldn't bet on ACPI+IO-APIC working on SiS.

2.5.x has the needed code to handle SiS APIC. Does Linus 2.5.70 also
have the fixes to not re-route the SMI pins ?

