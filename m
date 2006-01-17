Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWAQE7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWAQE7n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 23:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWAQE7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 23:59:43 -0500
Received: from xenotime.net ([66.160.160.81]:50840 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751108AbWAQE7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 23:59:42 -0500
Date: Mon, 16 Jan 2006 20:59:37 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, james.bottomley@steeleye.com
Subject: Re: [PATCH/RFC] SATA in its own config menu
Message-Id: <20060116205937.5f593356.rdunlap@xenotime.net>
In-Reply-To: <43CBAABC.6070200@pobox.com>
References: <20060115135728.7b13996d.rdunlap@xenotime.net>
	<43CBAABC.6070200@pobox.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2006 09:16:28 -0500 Jeff Garzik wrote:

> Randy.Dunlap wrote:
> > From: Randy Dunlap <rdunlap@xenotime.net>
> > 
> > Put SATA into its own menu.  Reason:  using SCSI is an
> > implementation detail that users need not know about.
> > 
> > Enabling SATA selects SCSI since SATA uses SCSI as a function
> > library supplier.  It also enables BLK_DEV_SD since that is
> > what SATA drives look like in Linux.
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> > ---
> >  drivers/Kconfig           |    2 
> >  drivers/scsi/Kconfig      |  138 --------------------------------------------
> >  drivers/scsi/Kconfig.sata |  142 ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 144 insertions(+), 138 deletions(-)
> 
> This needs to be done after the code gets moved to drivers/ata...

Thanks.  It was an RFC and it got comments.
That's all that I hoped for.

---
~Randy
