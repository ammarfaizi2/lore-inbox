Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbUJYN1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbUJYN1N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 09:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbUJYNZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 09:25:25 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:6328 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261799AbUJYNY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 09:24:29 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Stelian Pop <stelian@popies.net>
Subject: Re: [PATCH 5/5] Sonypi: use pci_get_device
Date: Mon, 25 Oct 2004 08:24:21 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200410210154.58301.dtor_core@ameritech.net> <200410210159.38252.dtor_core@ameritech.net> <20041025125731.GG6027@crusoe.alcove-fr>
In-Reply-To: <20041025125731.GG6027@crusoe.alcove-fr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410250824.22348.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 October 2004 07:57 am, Stelian Pop wrote:
> On Thu, Oct 21, 2004 at 01:59:35AM -0500, Dmitry Torokhov wrote:
> 
> > ChangeSet@1.1980, 2004-10-21 01:48:41-05:00, dtor_core@ameritech.net
> >   Sonypi: switch from pci_find_device to pci_get_device.
> [...]
> > +	struct pci_dev *pcidev;
> > +
> > +	pcidev = pci_find_device(PCI_VENDOR_ID_INTEL,
> > +				 PCI_DEVICE_ID_INTEL_82371AB_3,
> > +				 NULL);
> 
> I guess this is supposed to be pci_get_device no ? :)
> 

Ahem... well.. yes ;)

-- 
Dmitry

