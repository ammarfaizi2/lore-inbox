Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWBZTbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWBZTbb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 14:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWBZTbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 14:31:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6797 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932237AbWBZTba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 14:31:30 -0500
Date: Sun, 26 Feb 2006 14:31:21 -0500
From: Dave Jones <davej@redhat.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Building 100 kernels; we suck at dependencies and drown in warnings
Message-ID: <20060226193121.GG7851@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
References: <200602261721.17373.jesper.juhl@gmail.com> <9a8748490602260831l3338f03ew60f99648848aa177@mail.gmail.com> <9a8748490602260835l2430e841p2bf02c1f99e55b91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490602260835l2430e841p2bf02c1f99e55b91@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 05:35:49PM +0100, Jesper Juhl wrote:

 > And for those who want to see a list of the unique errors, here they are :
 > 
 > make: *** [.tmp_vmlinux1] Error 1
 > make: *** [arch/i386/kernel] Error 2
 > make: *** [drivers] Error 2
 > make: *** [sound] Error 2
 > make: *** [vmlinux] Error 1
 > make[1]: *** [arch/i386/kernel/irq.o] Error 1
 > make[1]: *** [drivers/acpi] Error 2
 > make[1]: *** [drivers/atm] Error 2
 > make[1]: *** [drivers/isdn] Error 2
 > make[1]: *** [drivers/media] Error 2
 > make[1]: *** [drivers/mtd] Error 2
 > make[1]: *** [drivers/scsi] Error 2
 > make[1]: *** [drivers/usb] Error 2
 > make[1]: *** [sound/isa] Error 2
 > make[1]: *** [sound/oss] Error 2
 > make[2]: *** [drivers/acpi/numa.o] Error 1
 > make[2]: *** [drivers/acpi/numa.o] Error 1  LD [M]  fs/ext3/ext3.o
 > make[2]: *** [drivers/acpi/osl.o] Error 1
 > make[2]: *** [drivers/atm/fore200e_pca_fw.c] Error 254
 > make[2]: *** [drivers/isdn/hysdn] Error 2
 > make[2]: *** [drivers/media/dvb] Error 2
 > make[2]: *** [drivers/mtd/maps] Error 2
 > make[2]: *** [drivers/scsi/aic7xxx] Error 2
 > make[2]: *** [drivers/usb/net] Error 2
 > make[2]: *** [sound/isa/opti9xx] Error 2
 > make[3]: *** [drivers/isdn/hysdn/hysdn_net.o] Error 1
 > make[3]: *** [drivers/media/dvb/ttpci] Error 2
 > make[3]: *** [drivers/mtd/maps/nettel.o] Error 1
 > make[3]: *** [drivers/scsi/aic7xxx/aicasm/aicasm] Error 2
 > make[3]: *** [drivers/usb/net/cdc_subset.o] Error 1
 > make[3]: *** [sound/isa/opti9xx/opti92x-ad1848.o] Error 1
 > make[3]: *** [sound/isa/opti9xx/opti93x.o] Error 1
 > make[4]: *** [aicasm] Error 1
 > make[4]: *** [drivers/media/dvb/ttpci/av7110_firm.h] Error 255

You snipped out the interesting parts, which is 1-2 lines before this
(Grepping for Error: should do it)

		Dave

