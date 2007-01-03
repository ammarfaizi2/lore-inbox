Return-Path: <linux-kernel-owner+w=401wt.eu-S932106AbXACWHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbXACWHA (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 17:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbXACWG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 17:06:59 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:52225 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751009AbXACWG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 17:06:59 -0500
Subject: Re: [PATCH 5/5] lpfc : Make Emulex lpfc driver legacy I/O port free
From: James Bottomley <James.Bottomley@SteelEye.com>
To: James.Smart@Emulex.Com
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       Andrew Morton <akpm@osdl.org>, e1000-devel@lists.sourceforge.net,
       linux-scsi@vger.kernel.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
In-Reply-To: <4564706E.9060900@emulex.com>
References: <4564051C.3080908@jp.fujitsu.com>  <4564706E.9060900@emulex.com>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 16:06:48 -0600
Message-Id: <1167862008.2789.81.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-22 at 10:44 -0500, James Smart wrote:
> ACK  :)
> 
> (I thought this had already gone in a while ago)

Actually, there seems to be missing infrastructure for this:

  CC [M]  drivers/scsi/lpfc/lpfc_init.o
drivers/scsi/lpfc/lpfc_init.c: In function 'lpfc_pci_probe_one':
drivers/scsi/lpfc/lpfc_init.c:1418: warning: implicit declaration of function 'pci_select_bars'
drivers/scsi/lpfc/lpfc_init.c:1422: warning: implicit declaration of function 'pci_request_selected_regions'
drivers/scsi/lpfc/lpfc_init.c:1734: warning: implicit declaration of function 'pci_release_selected_regions'

Is there any ETA on the rest of the infrastructure?

James


