Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbTJZBL5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 21:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262841AbTJZBL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 21:11:57 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:63874 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S262839AbTJZBL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 21:11:56 -0400
Date: Sun, 26 Oct 2003 02:11:46 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] give SATA its' own menu
Message-ID: <20031026011145.GB23690@vana.vc.cvut.cz>
References: <20031026001554.GC23291@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031026001554.GC23291@fs.tum.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 26, 2003 at 02:15:54AM +0200, Adrian Bunk wrote:
> Hi Jeff,
> 
> for an average user it's non-obvious to search for SATA support under 
> SCSI. The patch below moves SATA suport out of SCSI and gives it an own 
> menu below SCSI.

Will users know that they have to enable SCSI disk & cdrom support to get
it really to work?
								Petr
 
> +config SCSI_SATA
> +	bool "Serial ATA (SATA) support"
> +	depends on EXPERIMENTAL
> +	select SCSI
> +	help
> +	  This driver family supports Serial ATA host controllers
> +	  and devices.
> +
> +	  If unsure, say N.
