Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278283AbRJMMu6>; Sat, 13 Oct 2001 08:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278285AbRJMMus>; Sat, 13 Oct 2001 08:50:48 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:780 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S278283AbRJMMuc>;
	Sat, 13 Oct 2001 08:50:32 -0400
Date: Sat, 13 Oct 2001 14:51:00 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI device search.
Message-ID: <20011013145100.A25027@ontario.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <20011012135556.A21296@kroah.com> <Pine.LNX.3.96.1011012161504.13514A-100000@mandrakesoft.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.3.96.1011012161504.13514A-100000@mandrakesoft.mandrakesoft.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2001 at 04:15:54PM -0500, Jeff Garzik wrote:

> > I'd say 1.  If a device is hotpluggable or not does not matter.  For
> > 2.5, the boot process will be able to load modules for all PCI
> > devices seen in the system.  In order for that to happen, they need to
> > use the MODULE_DEVICE structure and the 2.4 pci driver subsystem.
> 
> I'd say 1.5.  :)  For the "newer hardware" consider using the PCI host
> bridge or ISA bridge for your "container" PCI device.

You mean putting PCI_CLASS_BRIDGE_PCI as pattern in the pci
search table, yes ?

Thanks.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
