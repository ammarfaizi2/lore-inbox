Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279858AbRKNAGl>; Tue, 13 Nov 2001 19:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279865AbRKNAGc>; Tue, 13 Nov 2001 19:06:32 -0500
Received: from [212.98.85.178] ([212.98.85.178]:44298 "EHLO web1.luka.de")
	by vger.kernel.org with ESMTP id <S279858AbRKNAGY>;
	Tue, 13 Nov 2001 19:06:24 -0500
Date: Wed, 14 Nov 2001 01:04:37 +0100
From: Christoph Kampe <kernelml@kampe.net>
To: linux-kernel@vger.kernel.org
Subject: Re: usb-storage fails with datafab md2-usb (ide hdd on usb) on newer kernels >2.4.8
Message-ID: <20011114010437.B1174@kampe.net>
In-Reply-To: <20011114004123.A1174@kampe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011114004123.A1174@kampe.net>
User-Agent: Mutt/1.3.23i
X-Operating-System: greedy on Linux 2.4.8 i686 for kampe.net
X-PGP-Key: http://www.kampe.net/pubkey.asc
X-PGP-Fingerprint: 4286 CA6C AFD8 BD70 4B8F  78B8 733A 4B40 DFC5 1CF7
X-PGP-ID: 0xDFC51CF7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2001 at 12:41:23AM +0100, Christoph Kampe wrote:
... very much, but not the Problemdescription.

Hi again,
sorry i forget to write what went wrong with the DataFab Storage.

Actually, with 2.4.8 when i connect the usb-storage it loads all
necessary modules and a mount takes less then 1second.

With 2.4.15-pre4 it loads the three modules too but, it gives 
> kernel: usb-storage: *** thread sleeping.
> kernel: scsi: device set offline - not ready or command retry failed after 
>   bus reset: host 0 channel 0 id 0 lun 0
> kernel:  I/O error: dev 08:05, sector 0
in my log.
as i wrote in my last mail (last 10 lines)
a mount won´t work, takes some time and breaks with 
"I/O error:dev 08:05, sector 0"

I dont´t know exactly if it fails because of the usb-storage or the 
scsi_mod module.

Regards 
Christoph

