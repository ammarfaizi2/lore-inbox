Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbVLKQI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbVLKQI6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 11:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVLKQI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 11:08:57 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:58003 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750733AbVLKQIk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 11:08:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wha+uLGTWLofyaV1Y1vv4EeVR4YJ8ErY80498omh96QBX2494CZvZQSL07+zCkcXjphr5mZEpDPC5pgBxyYt/2JjmwfTjPDVA6r/F1z/e3sSkL7WcJa3HU0PM618ZNSYZ75Swzn8mVyN8Mm9km8Q2GTo/DI5HT6U8RQ4gtWlTBs=
Message-ID: <9a8748490512110808q2d485407o52da0d4777fbf38e@mail.gmail.com>
Date: Sun, 11 Dec 2005 17:08:39 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-rc5-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051211041308.7bb19454.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051211041308.7bb19454.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/05, Andrew Morton <akpm@osdl.org> wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm2/
>
When booting this kernel with  vga=791 like I normally do, the kernel
hangs on boot. Booting with vga=normal works just fine.
I don't have very much info since as soon as the videomode is switched
I get a small rectangle of messed up colours in the top left corner of
the screen (the rest is just black) and then it hangs - even the
keyboard is dead, I have to powercycle the machine.
Nothing makes it to the logs and I don't have a second machine atm to
get logs via serial console or netconsole.
I've got the vesafb driver build in, none of the other fb drivers.

Videocard is :

01:05.0 VGA compatible controller: Matrox Graphics, Inc. MGA Parhelia
AGP (rev 03) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Parhelia 128Mb
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 4
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at e5000000 (32-bit, non-prefetchable) [size=8K]
        Expansion ROM at e7fe0000 [disabled] [size=128K]
        Capabilities: <available only to root>
00: 2b 10 27 05 07 00 b0 02 03 00 00 03 08 40 00 00
10: 08 00 00 e8 00 00 00 e5 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 40 08
30: 00 00 fe e7 dc 00 00 00 00 00 00 00 04 01 10 20


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
