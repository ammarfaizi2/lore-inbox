Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263986AbSLLMZT>; Thu, 12 Dec 2002 07:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263991AbSLLMZT>; Thu, 12 Dec 2002 07:25:19 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:49605
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263986AbSLLMZT>; Thu, 12 Dec 2002 07:25:19 -0500
Subject: Re: Linux 2.4.21-pre1 IDE
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: andersen@codepoet.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20021212013546.GA30408@codepoet.org>
References: <Pine.LNX.4.50L.0212101834240.23096-100000@freak.distro.conectiva> 
	<20021212013546.GA30408@codepoet.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Dec 2002 13:10:48 +0000
Message-Id: <1039698648.21446.30.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-12 at 01:35, Erik Andersen wrote:
>     hda: DMA disabled
>     ^^^^^^^^^^^^^^^^^
> 
> What's up with this?  For each drive in my system it claims it
> has disabled DMA.  But hdparm later reports that DMA is in fact
> enabled.  In fact, later on the kernel ever reports the drive
> as being in UDMA 100 mode...  I think these "DMA disabled"
> messages are bogus.

Cosmetic and known. It in fact turns DMA back on - quietly

>     ide2 at 0x1800-0x1807,0xac02 on irq 11
>     hda: host protected area => 1
>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     hda: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=10011/255/63, UDMA(100)
> 
> Now we see the funky "host protected area => 1" message.  As
> discussed earlier with Andre, this message should be removed from
> the kernel.  The message as written implies that the driv

Before 2.4.21 agreed


