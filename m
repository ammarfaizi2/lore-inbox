Return-Path: <linux-kernel-owner+w=401wt.eu-S932158AbXACW2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbXACW2v (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 17:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbXACW2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 17:28:51 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:52363 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932154AbXACW2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 17:28:50 -0500
Subject: Re: [PATCH 5/5] lpfc : Make Emulex lpfc driver legacy I/O port free
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: James.Smart@Emulex.Com, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       e1000-devel@lists.sourceforge.net, linux-scsi@vger.kernel.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
In-Reply-To: <20070103142349.6f8b0310.akpm@osdl.org>
References: <4564051C.3080908@jp.fujitsu.com> <4564706E.9060900@emulex.com>
	 <1167862008.2789.81.camel@mulgrave.il.steeleye.com>
	 <20070103142349.6f8b0310.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 16:28:40 -0600
Message-Id: <1167863321.2789.83.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2007-01-03 at 14:23 -0800, Andrew Morton wrote:
> > drivers/scsi/lpfc/lpfc_init.c: In function 'lpfc_pci_probe_one':
> > drivers/scsi/lpfc/lpfc_init.c:1418: warning: implicit declaration of function 'pci_select_bars'
> > drivers/scsi/lpfc/lpfc_init.c:1422: warning: implicit declaration of function 'pci_request_selected_regions'
> > drivers/scsi/lpfc/lpfc_init.c:1734: warning: implicit declaration of function 'pci_release_selected_regions'
> 
> That's here, in Greg's PCI tree:

Ah, OK, thanks!

> http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-02-pci/pci-add-selected_regions-funcs.patch
> 
> > Is there any ETA on the rest of the infrastructure?
> > 
> 
> It doesn't look like a bugfix :(

OK, I'll defer this then ... someone remind me when 2.6.20 rolls around.

James


