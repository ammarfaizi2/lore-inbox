Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265284AbSJXBRA>; Wed, 23 Oct 2002 21:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbSJXBRA>; Wed, 23 Oct 2002 21:17:00 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:64300 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265284AbSJXBQ7>; Wed, 23 Oct 2002 21:16:59 -0400
Date: Wed, 23 Oct 2002 21:23:08 -0400
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: serial nits in 2.5.44 with cardbus modem
Message-ID: <20021023212308.E32466@devserv.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xircom cardbus ethernet/modem combo

1) the serial port is now /dev/ttyS14. It was /dev/ttyS04 under
   2.4.x.
2) modprobe -r 8250_pci gives:

   kernel: Trying to free nonexistent resource <00005080-00005087>

On load, I see:
 
 kernel: Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
 kernel: ttyS14 at I/O 0x5080 (irq = 11) is a 16550A

Bill
