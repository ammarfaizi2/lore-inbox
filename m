Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266078AbSLNXpn>; Sat, 14 Dec 2002 18:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266081AbSLNXpn>; Sat, 14 Dec 2002 18:45:43 -0500
Received: from vsmtp3.tin.it ([212.216.176.223]:12951 "EHLO smtp3.cp.tin.it")
	by vger.kernel.org with ESMTP id <S266078AbSLNXpm>;
	Sat, 14 Dec 2002 18:45:42 -0500
Message-ID: <3DFBC4F3.2070603@tin.it>
Date: Sun, 15 Dec 2002 00:55:31 +0100
From: AnonimoVeneziano <voloterreno@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021210 Debian/1.2.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: IDE-CD and VT8235 issue!!!
References: <3DFB7B21.7040004@tin.it> <200212142019.14449.black666@inode.at>
In-Reply-To: <200212142019.14449.black666@inode.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Petermair wrote:

>Hi!
>
>Same problem here. I have addressed this issue several times...so far no 
>solution.
>
>My specs:
>MSI KT3 Ultra2 (VT8235)
>TOSHIBA DVD-ROM SD-M1302
>YAMAHA CRW8424E
>
>Kernel 2.4.19:
>The one I'm currently using. It doesn't detect the VT8235 and therefore 
>I have no dma. But I can access/mount my DVD without a problem.
>
>Kernel 2.4.20:
>Detects the VT8235 at boot but hangs with my DVD Rom (hdc) --> doesn't 
>boot. I have posted my problem here an Alan Cox suggested that I should 
>try the -ac tree.
>
>Kernel 2.4.20-ac2:
>Some improvements - It detects the VT8235 at boot, also my DVD and CDRW. 
>It boots fine and I have DMA on all my discs. But as soon as I try to 
>mount a CD/DVD (mount /cdrom) the system hangs and I get this:
>
>hdc: status timeout: status=0xd1 { Busy }
>hdc: status timeout: error=0x60LastFailedSense 0x06
>hdc: DMA disabled
>hdc: ATAPI reset timed-out, status=0x80
>hdd: DMA disabled
>ide1: reset: success
>hdc: status timeout: status=0x80 { Busy }
>hdc: status timeout: error=0x01IllegalLengthIndication
>hdc: ATAPI reset timed-out, status=0xd1
>ide1: reset: success
>hdc: status timeout: status=0x80 { Busy }
>hdc: status timeout: error=0x01IllegalLengthIndication
>end_request: I/O error, dev 16:00 (hdc), sector 0
>hdc: status timeout: status=0xd0 { Busy }
>
>and so on...
>
>My guess is the DVD-drive. I know many people with the same southbridge 
>(VT8235), who have dma since 2.4.20 an no problem at all at boot-time 
>or mounting a CD/DVD.
>
>Any hints?
>
>Patrick
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Please, anyone help us, I can't live with a 6 MB HD bandwith!!!:-D

Ciao

