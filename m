Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129309AbQKULXF>; Tue, 21 Nov 2000 06:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQKULWz>; Tue, 21 Nov 2000 06:22:55 -0500
Received: from ganymede.cdt.luth.se ([130.240.64.41]:59401 "HELO
	ganymede.cdt.luth.se") by vger.kernel.org with SMTP
	id <S129309AbQKULWp> convert rfc822-to-8bit; Tue, 21 Nov 2000 06:22:45 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Hakan Lennestal <hakanl@cdt.luth.se>
Reply-To: Hakan Lennestal <hakanl@cdt.luth.se>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Hakan Lennestal <hakanl@cdt.luth.se>, linux-kernel@vger.kernel.org,
        andre@linux-ide.org
Subject: Re: 2.4.0, test10, test11: HPT366 problem 
In-Reply-To: Your message of "Tue, 21 Nov 2000 10:35:05 GMT."
             <5117.974802905@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Date: Tue, 21 Nov 2000 11:52:43 +0100
Message-Id: <20001121105243.A933526@ganymede.cdt.luth.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <5117.974802905@redhat.com>, David Woodhouse writes:

> You mean this?
> 
> 	hde: timeout waiting for DMA
> 	ide_dmaproc: chipset supported ide_dma_timeout func only: 14

Indeed.

> I see identical hangs when I have a similar IBM-DTLA drive attached 
> anywhere on the HPT366. But I also see it hang on 2.2.17 if I try:
> 
>  hdparm -t /dev/hde & hdparm -t /dev/hde & hdparm -t /dev/hde

Yes, with udma4 it hangs sooner or later for me also, both under 
2.2.* and 2.4.0.

Udma3 seem to be rock solid though as long as it manages to pass the partition 
detection during boot up.

Regards.

/Håkan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
