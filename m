Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVGDVn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVGDVn7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 17:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVGDVn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 17:43:59 -0400
Received: from iron.pdx.net ([207.149.241.18]:40873 "EHLO iron.pdx.net")
	by vger.kernel.org with ESMTP id S261696AbVGDVnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 17:43:55 -0400
Subject: [WORKAROUND] For ASUS K8N-DL PCI allocation issues
From: Sean Bruno <sean.bruno@dsl-only.net>
To: Alexander Nyberg <alexn@telia.com>
Cc: bcoffman@infofromdata.com, Karim Yaghmour <karim@opersys.com>,
       Peter Buckingham <peter@pantasys.com>, Andi Kleen <ak@muc.de>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       "Hodle, Brian" <BHodle@harcroschem.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'ipsoa@posiden.hopto.org'" <ipsoa@posiden.hopto.org>
In-Reply-To: <1120510973.5304.6.camel@home-lap>
References: <D9A1161581BD7541BC59D143B4A06294021FAAAF@KCDC1>
	 <1120246927.2764.26.camel@home-lap>
	 <200507021843.45450.s0348365@sms.ed.ac.uk>  <20050702194455.GA80118@muc.de>
	 <1120365125.4107.4.camel@home-lap>
	 <1120376236.1175.1.camel@localhost.localdomain>
	 <1120507617.5304.1.camel@home-lap>  <1120510973.5304.6.camel@home-lap>
Content-Type: text/plain
Date: Mon, 04 Jul 2005 14:43:50 -0700
Message-Id: <1120513431.5304.17.camel@home-lap>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have determined that if you disable ACPI altogether in the BIOS I can
actually use the on-board hardware.  There are still allocation issues,
but I can access the USB controller, Sound and Broadcom ethernet adapter
at this point.  I haven't tested any further and would like some other
K8N-DL users to test my findings and make sure that this is the only
setting required to make the board functional at this point.

With BIOS 1003, enter the BIOS and move to POWER.  Set ACPI APIC Support
to Disabled and reboot.  

There is a small chance that you will also have to set the IRQ's of all
device manually. 

Sean

