Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbTFCUOt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 16:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264101AbTFCUOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 16:14:49 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:58586 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264097AbTFCUOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 16:14:47 -0400
Date: Tue, 3 Jun 2003 15:28:47 -0400
From: Ben Collins <bcollins@debian.org>
To: Jocelyn Mayer <jma@netgem.com>
Cc: Georg Nikodym <georgn@somanetworks.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] ieee1394 sbp2 driver is broken for kernel >= 2.4.21-rc2
Message-ID: <20030603192847.GF10102@phunnypharm.org>
References: <1054582582.4967.48.camel@jma1.dev.netgem.com> <20030602163443.2bd531fb.georgn@somanetworks.com> <1054588832.4967.77.camel@jma1.dev.netgem.com> <20030603113636.GX10102@phunnypharm.org> <1054663917.4967.99.camel@jma1.dev.netgem.com> <20030603185421.GB10102@phunnypharm.org> <1054671619.4951.139.camel@jma1.dev.netgem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054671619.4951.139.camel@jma1.dev.netgem.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Attached devices: 
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: SONY     Model: CD-RW  CRX800E   Rev: 1.3p
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> Host: scsi1 Channel: 00 Id: 00 Lun: 00
>   Vendor: Maxtor 6 Model: Y080L0           Rev: YAR4
>   Type:   Direct-Access                    ANSI SCSI revision: 06
> 
> 
> So I NEVER write anything to /proc/scsi/scsi,
> I got NO /sbin/hotplug, I use only insmod,
> so I can have no side-effect due to modprobe usage,
> and it works PERFECTLY on the Ibook, 
> using the 2.4.21-rc1 ieee1394 stack.
> 
> So, I'm sorry, but I keep thinking the new driver is buggy:
> what used to work and doesn't...

Want to see buggy? After you load all this up on rc1, rmmod sbp2 and
then do:

cat /proc/scsi/sbp2/1

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
