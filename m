Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbTDHTFp (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 15:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbTDHTFo (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 15:05:44 -0400
Received: from pollux.ds.pg.gda.pl ([213.192.76.3]:29191 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261545AbTDHTFn (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 15:05:43 -0400
Date: Tue, 8 Apr 2003 21:17:16 +0200 (CEST)
From: =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.67
In-Reply-To: <Pine.LNX.4.44.0304071051190.1385-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.51L.0304082115060.20726@piorun.ds.pg.gda.pl>
References: <Pine.LNX.4.44.0304071051190.1385-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Apr 2003, Linus Torvalds wrote:
> All over the place as usual - there's definitely a lot of small things 
> going on. PCMCIA and i2c updates may be the most noticeable ones.

I've got some unresolved symbols with that kernel:
/sbin/depmod -ae -F System.map  2.5.67; fi
WARNING: /lib/modules/2.5.67/kernel/drivers/md/xor.ko needs unknown symbol kernel_fpu_begin
WARNING: /lib/modules/2.5.67/kernel/drivers/scsi/aha152x.ko needs unknown symbol scsi_put_command
WARNING: /lib/modules/2.5.67/kernel/drivers/scsi/aha152x.ko needs unknown symbol scsi_get_command
WARNING: /lib/modules/2.5.67/kernel/drivers/hotplug/acpiphp.ko needs unknown symbol acpi_resource_to_address64

My kernel config: http://piorun.ds.pg.gda.pl/~blues/config-2.5.67.txt

-- 
pozdr.  Pawe³ Go³aszewski        
---------------------------------
worth to see: http://www.againsttcpa.com/
CPU not found - software emulation...
