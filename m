Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316754AbSE0UVl>; Mon, 27 May 2002 16:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316755AbSE0UVk>; Mon, 27 May 2002 16:21:40 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:34801 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316754AbSE0UVk>; Mon, 27 May 2002 16:21:40 -0400
Subject: Re: Kernel (2.4.19-pre8) hang
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Frederik Nosi <fredi@e-salute.it>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1022527454.1606.22.camel@linux>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 May 2002 22:24:10 +0100
Message-Id: <1022534650.11859.316.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-27 at 20:24, Frederik Nosi wrote:
> May 27 18:28:13 linux kernel: EXT3-fs error (device ide0(3,7)):
> ext3_free_blocks: bit already cleared for block 215665
> 
> I suspect at my hd too but for being sure... Please CC me because I'm
> not subscribed to the list and excuse me for my bad english and the long
> mail.

What mode is your hard disk reported to be in. If it is using UDMA then
its very unlikely to be the disk itself. We also should now have all the
needed workarounds for VIA chipset bugs.

Has this box been stable with older kernels ?

Alan

