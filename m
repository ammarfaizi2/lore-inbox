Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWBKV4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWBKV4G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 16:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWBKV4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 16:56:06 -0500
Received: from angel35-131-99-82-liberec.bluetone.cz ([82.99.131.35]:54917
	"EHLO anubis.vysinka.tfn") by vger.kernel.org with ESMTP
	id S1750736AbWBKV4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 16:56:04 -0500
Message-ID: <43EE5D68.5080501@turnovfree.net>
Date: Sat, 11 Feb 2006 22:55:52 +0100
From: Zdenek Styblik <stybla@turnovfree.net>
Organization: TurnovFree.net
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NCR 53c700-66 MCA(EISA) doesn't want to work(2.4.x)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have Intel Professional Workstation with LP468 motherboard which has
everything else except PCI. There is integrated SCSI controller NCR
53c700-66 50pin which is probably on MCA(or EISA bus). Problem is that
I can't make it work. I tried NCR 53c7xx, 8xx support(naturally), but
no way. I tried all other drivers, but no success. Googling around was
also unsuccessful. Everything points on that it should work, but it
does not.

# quote from Intel Professional Workstation documentation
1. NCR 53C700 SCSI I/O Processor (SIOP)
The on-board SCSI I/O processor is a NCR 53C700. This component has
internal FIFOs on the SCSI and host data
busses, 32-bit address and data busses, and an internal SCRIPTS
processor capable of fast DMA. A custom ASIC is
used to convert the 386-like bus interface of the NCR 53C700 to the
asynchronous strobed interface required by the
82359 DRAM Controller. The SIOP runs at 33 MHz, the maximum
theoretical data transfer rate is 66 MBytes/sec across
the Buffered Bus, and 8.25 MBytes/sec across the SCSI bus.
# end of quote

Do you have any ideas how to make this SCSI controller to work?

Thank you very much for your replies.

Zdenek Styblik
