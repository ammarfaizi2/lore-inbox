Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030391AbWALMxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbWALMxm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 07:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWALMxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 07:53:42 -0500
Received: from mail.gmx.de ([213.165.64.21]:55188 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964912AbWALMxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 07:53:42 -0500
X-Authenticated: #1890154
Subject: Re: Kernel 2.6.15 sometimes only detects one of two SATA drives
	and panics
From: Andre Hessling <ahessling@gmx.de>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <43C60D01.5080808@reub.net>
References: <1137003241.7603.20.camel@localhost.localdomain>
	 <20060111234011.451c5c36.akpm@osdl.org>  <43C60D01.5080808@reub.net>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 13:53:50 +0100
Message-Id: <1137070430.14429.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 12.01.2006, 21:02 +1300 schrieb Reuben Farrelly:

> Hard to be sure, on this one I'm not convinced.  With mine, both controllers are 
> recognised but display timeout messages which are not shown by the sequences 
> reported below.

I accidently skipped one line when the kernel panics:
Right after the lines
Jan 11 17:57:43 localhost kernel: ata1: dev 0 configured for UDMA/133
Jan 11 17:57:43 localhost kernel: scsi0 : ata_piix

it is also said:
ata2: SATA port has no device.
scsi1 : ata_piix
[...]

So it doesn't seem to find any devices on the second SATA port.

Maybe that is important, too.

> Andre: serial console is your friend ;)

Hm, I don't have a serial port on my other machine.
-- 
Regards, Andre

