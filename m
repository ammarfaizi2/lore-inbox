Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267453AbUGNQix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267453AbUGNQix (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 12:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267455AbUGNQix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 12:38:53 -0400
Received: from web90007.mail.scd.yahoo.com ([66.218.94.65]:53378 "HELO
	web90007.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S267453AbUGNQiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 12:38:46 -0400
Message-ID: <20040714163846.13370.qmail@web90007.mail.scd.yahoo.com>
Date: Wed, 14 Jul 2004 09:38:46 -0700 (PDT)
From: Hlaing Oo <hlaing_1999@yahoo.com>
Subject: Re: missing cdrom in new kernel 2.4.26
To: Edward Macfarlane Smith <snowfire@blueyonder.co.uk>,
       Martin Zwickel <martin.zwickel@technotrend.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200407141642.14047.snowfire@blueyonder.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Edward and Martin

Got it!!
Thank you very very much.
I got more knowledge on kernel.
thank you both.
Regards
hlaing oo
--- Edward Macfarlane Smith
<snowfire@blueyonder.co.uk> wrote:
> On Wednesday 14 July 2004 13:17, Hlaing Oo wrote:
> 
> > >>>>> my new kernel dmesg is below
> >
> > #cat /var/log/dmesg
> > Linux version 2.4.26 (root@localhost.localdomain)
> (gcc
> > version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #3
> SMP
> 
> > BIOS strings suggest APM reports battery life in
> > minutes and wrong byte order.
> > Kernel command line: ro root=/dev/hda2
> hdc=ide-scsi
> > ide_setup: hdc=ide-scsi
> ---cut---
> old
> > EXT3-fs: mounted filesystem with ordered data
> mode.
> > SCSI subsystem driver Revision: 1.00
> > scsi0 : SCSI host adapter emulation for IDE ATAPI
> > devices
> >   Vendor: MATSHITA  Model: UJDA310           Rev:
> 1.34
> >   Type:   CD-ROM                             ANSI
> SCSI
> > revision: 02
> 
> In both old and new you are passing in hdc=ide-scsi
> on the boot line, telling 
> the kernel to use ide-scsi  for hdc. (I'd guess that
> /dev/cdrom points 
> to /dev/sr0). The bit below shows that it has
> correctly inserted the ide-scsi 
> module in your old kernel and detected the cdrom.
> That is missing from the 
> new one. Are you sure you built the ide-scsi module
> in your new kernel? Have 
> you checked /var/log/messages or /var/log/warn to
> see if there were any 
> errors about problems with the ide-scsi module?
> Fairly certain I remember getting the same error one
> time when I forgot to 
> build ide-scsi.
> Regards,
> Edward
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
