Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbTJ0SSd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 13:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbTJ0SSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 13:18:33 -0500
Received: from havoc.gtf.org ([63.247.75.124]:1209 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263472AbTJ0SSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 13:18:32 -0500
Date: Mon, 27 Oct 2003 13:15:29 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Arve Knudsen <aknuds-1@broadpark.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6t9 SATA slower than 2.4.20
Message-ID: <20031027181529.GA5335@gtf.org>
References: <3F9D402F.9050509@savages.net> <20031027165916.GE19711@gtf.org> <oprxppvbgvq1sf88@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oprxppvbgvq1sf88@mail.broadpark.no>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 06:36:37PM +0100, Arve Knudsen wrote:
> On Mon, 27 Oct 2003 11:59:17 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> >On Mon, Oct 27, 2003 at 07:56:31AM -0800, Shaun Savage wrote:
> >>
> >>
> >>>Are you using CONFIG_SCSI_SATA in 2.6?
> >>
> >>No, but I am trying now.
> >>GREAT is works,
> >>but the disk went from hda back to hde
> >
> >hmmm, with CONFIG_SCSI_SATA your SATA drives should show up as
> > /dev/sda not /dev/hde ...
> >
> >So, you're still using the drivers/ide driver, it appears.
> >
> >Regardless, it's most important to use what works for you ;-)
> >
> Excuse me, there's probably something I'm missing, but how do I use the 
> SCSI_SATA driver for SiI 3112? I see the source file for it in the kernel 
> tree (test9), but no option for it in menuconfig (I've enabled SATA under 
> SCSI). Enabling the SiI SATA driver under ATA/ATAPI... compiles in the old 
> driver am I right?

For SiI, it requires CONFIG_BROKEN, because, well, the libata SiI
is "very alpha quality" right now ;-)

	Jeff



