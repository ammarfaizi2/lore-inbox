Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbUCaVkj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 16:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbUCaVij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 16:38:39 -0500
Received: from pop.gmx.de ([213.165.64.20]:35233 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262547AbUCaViM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 16:38:12 -0500
X-Authenticated: #1045983
From: Helge Deller <deller@gmx.de>
To: Len Brown <len.brown@intel.com>
Subject: Re: Linux 2.6.5-rc3 - ALI15X3, irq 15: nobody cared! / Disabling IRQ #15
Date: Wed, 31 Mar 2004 23:38:05 +0200
User-Agent: KMail/1.6.51
Cc: linux-kernel@vger.kernel.org
References: <A6974D8E5F98D511BB910002A50A6647615F6E02@hdsmsx402.hd.intel.com> <1080753945.21276.4.camel@dhcppc4>
In-Reply-To: <1080753945.21276.4.camel@dhcppc4>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200403312338.05557.deller@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 March 2004 19:25, Len Brown wrote:
> On Tue, 2004-03-30 at 14:40, Helge Deller wrote:
> > IBM R30 Laptop, ALI15X3 IDE onboard chip, internal IDE harddisk &
> > CDROM gives
> >  irq 15: nobody cared!
> >  ....
> >  Disabling IRQ #15
> 
> Did 2.6.5-rc2 work okay?

yes.
 
> Nothing ACPI jumps out at me here, but if you boot with acpi=off
> or pci=noacpi and the problem goes away, then let me know.

2.6.5-rc2 is OK,
2.5.6-rc3 is broken,
2.5.6-rc3 pci=noacpi is OK,
2.5.6-rc3 acpi=off is OK

Helge
