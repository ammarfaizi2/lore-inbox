Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264395AbRFORjT>; Fri, 15 Jun 2001 13:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264213AbRFORjJ>; Fri, 15 Jun 2001 13:39:09 -0400
Received: from t111.niisi.ras.ru ([193.232.173.111]:6960 "EHLO
	t111.niisi.ras.ru") by vger.kernel.org with ESMTP
	id <S261173AbRFORi5>; Fri, 15 Jun 2001 13:38:57 -0400
Message-ID: <3B2A4760.9010704@niisi.msk.ru>
Date: Fri, 15 Jun 2001 21:35:28 +0400
From: Alexandr Andreev <andreev@niisi.msk.ru>
Organization: niisi
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.18 i586; en-US; rv:0.9) Gecko/20010507
X-Accept-Language: ru, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Using cramfs as root filesystem on diskless machine
In-Reply-To: <Pine.LNX.4.33.0106151824240.28914-100000@imladris.demon.co.uk>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:

>It's not polite to respond to private messages in public fora.
>
>On Fri, 15 Jun 2001, Alexandr Andreev wrote:
>
>>Bootloader only jumps to the kernel entry point. The initrd image is 
>>compiled inside the kernel.
>>
>
>So it's in a ROM or flash chip? Why copy it into memory then? We have 
>support for ROM and flash chips.
>
No any flash, disk, floppy... only RAM, image is inside kernel.
#ls -s vmlinux
4852 vmlinux
#objdump --headers vmlinux
.data
.text
.bss
.initrd <- Here is the image.
...


