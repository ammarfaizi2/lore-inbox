Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317512AbSFKSyE>; Tue, 11 Jun 2002 14:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317508AbSFKSyD>; Tue, 11 Jun 2002 14:54:03 -0400
Received: from jffdns02.or.intel.com ([134.134.248.4]:53498 "EHLO
	hebe.or.intel.com") by vger.kernel.org with ESMTP
	id <S317506AbSFKSyD>; Tue, 11 Jun 2002 14:54:03 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7EF6@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Felix Seeger'" <seeger@sitewaerts.de>, linux-kernel@vger.kernel.org
Subject: RE: Problem with ACPI or framebuffer (no output while startup)
Date: Tue, 11 Jun 2002 09:38:44 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Felix Seeger [mailto:seeger@sitewaerts.de] 
> > Executing device _INI methods: ............. (13 points)
> >
> > After that the output stops but the systems starts up, onyl 
> the output...

Known problem. ACPI is getting the bus wrong on PCI config space accesses
and accidentally turning off the video, I believe.

Regards -- Andy
