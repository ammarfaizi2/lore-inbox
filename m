Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbTIFPsd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 11:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbTIFPsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 11:48:33 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:61921 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261496AbTIFPsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 11:48:32 -0400
Subject: Re: [ACPI] [PATCH] 2.6.0-test4 ACPI fixes series (4/4)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org,
       lkml <linux-kernel@vger.kernel.org>, acpi-devel@lists.sourceforge.net,
       linux-acpi@intel.com
In-Reply-To: <200309060157.47121.adq_dvb@lidskialf.net>
References: <200309051958.02818.adq_dvb@lidskialf.net>
	 <200309060016.16545.adq_dvb@lidskialf.net> <3F590E28.6090101@pobox.com>
	 <200309060157.47121.adq_dvb@lidskialf.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062863230.2795.1.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sat, 06 Sep 2003 16:47:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-09-06 at 01:57, Andrew de Quincey wrote:
> This patch removes some erroneous code from mpparse which breaks IO-APIC programming

These shouldnt be removed but checked against the arch being an E7000,
which does need this.

