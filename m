Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030739AbWKUIzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030739AbWKUIzr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 03:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030738AbWKUIzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 03:55:46 -0500
Received: from c2bthomr01.btconnect.com ([194.73.73.209]:32070 "EHLO
	c2bthomr01.btconnect.com") by vger.kernel.org with ESMTP
	id S1030739AbWKUIzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 03:55:45 -0500
Subject: Re: [PATCH] PCMCIA identification strings for Elan -- second
	attempt
From: Tony Olech <tony.olech@elandigitalsystems.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux kernel development <linux-kernel@vger.kernel.org>,
       PCMCIA Maintainence <linux-pcmcia@lists.infradead.org>,
       David Hinds <dahinds@users.sourceforge.net>,
       Jaroslav Kysela <perex@suse.cz>,
       Bart Prescott <bart.prescott@elandigitalsystems.com>
In-Reply-To: <20061120174924.GC18660@isilmar.linta.de>
References: <200611201306.kAKD6gRt008347@imap.elan.private>
	 <20061120174924.GC18660@isilmar.linta.de>
Content-Type: text/plain
Organization: Elan Digital Systems Limited
Date: Tue, 21 Nov 2006 08:53:22 +0000
Message-Id: <1164099203.30853.51.camel@n04-143.elan.private>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
Elan-checked-message-originator: tony.olech@elandigitalsystems.com == tony-olech
Elan-message-recipient: linux@dominikbrodowski.net
Elan-message-recipient: linux-pcmcia@lists.infradead.org
Elan-message-recipient: perex@suse.cz
Elan-message-recipient: dahinds@users.sourceforge.net
Elan-message-recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

YES is does indeed have 4 serial channels.

Tony Olech
---------------------------------------------------------
On Mon, 2006-11-20 at 12:49 -0500, Dominik Brodowski wrote:
> Hi,
> 
> Patch looks good, except:
> 
> > +	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: CF332",0x3beb8cf2,0x16dc1ba7),
> > +	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: SL332",0x3beb8cf2,0x19816c41),
> > +	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: SL385",0x3beb8cf2,0x64112029),
> > +	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: SL432",0x3beb8cf2,0x1cce7ac4),
> > +	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial+Parallel Port: SP230",0x3beb8cf2,0xdb9e58bc),
> > +	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: CF332",0x3beb8cf2,0x16dc1ba7),
> > +	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: SL332",0x3beb8cf2,0x19816c41),
> > +	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: SL385",0x3beb8cf2,0x64112029),
> > +	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: SL432",0x3beb8cf2,0x1cce7ac4),
> > +	PCMCIA_MFC_DEVICE_PROD_ID12(2,"Elan","Serial Port: SL432",0x3beb8cf2,0x1cce7ac4),
> > +	PCMCIA_MFC_DEVICE_PROD_ID12(3,"Elan","Serial Port: SL432",0x3beb8cf2,0x1cce7ac4),
> 
> does the SL432 device have four independent multifunction subdevices? This
> would be something I haven't seen before, and which would likely not work
> with current code...
> 
> Thanks,
> 	Dominik
> 

