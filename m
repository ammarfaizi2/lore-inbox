Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVCHAmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVCHAmH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 19:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVCHAha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 19:37:30 -0500
Received: from farad.aurel32.net ([82.232.2.251]:49096 "EHLO farad.aurel32.net")
	by vger.kernel.org with ESMTP id S261854AbVCHAdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 19:33:36 -0500
Date: Tue, 8 Mar 2005 01:33:30 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] 2.6.x libata updates
Message-ID: <20050308003329.GA21516@bode.aurel32.net>
Mail-Followup-To: Aurelien Jarno <aurelien@aurel32.net>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <422C8B64.1020404@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <422C8B64.1020404@pobox.com>
X-Mailer: Mutt 1.5.6+20040907i (CVS)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 12:12:04PM -0500, Jeff Garzik wrote:

> Please do a
> 
> 	bk pull bk://gkernel.bkbits.net/libata-2.6
> 
> This will update the following files:
> 
>  drivers/scsi/libata-core.c |   16 ++++++----------
>  drivers/scsi/sata_nv.c     |    6 ++++--
>  drivers/scsi/sata_sil.c    |    2 +-
>  drivers/scsi/sata_svw.c    |    4 ++--
>  drivers/scsi/sata_vsc.c    |    3 ++-
>  5 files changed, 15 insertions(+), 16 deletions(-)
> 
> through these ChangeSets:
> 
> Adam J. Richter:
>   o ata_pci_remove_one used freed memory
> 
> Adrian Bunk:
>   o drivers/scsi/sata_*: make code static
> 
Is there any plan to include the ATA pass thru functionality into the main
kernel tree?

Thanks,
Aurelien

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
