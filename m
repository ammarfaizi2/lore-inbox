Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266186AbUHMQYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266186AbUHMQYG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 12:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266181AbUHMQYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 12:24:05 -0400
Received: from [213.146.154.40] ([213.146.154.40]:51904 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266173AbUHMQYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 12:24:02 -0400
Subject: Re: About the decompression of compressed kernel image
From: David Woodhouse <dwmw2@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Zhan Rongkai <zhanrk2000@yahoo.com.au>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.58.0408131732510.28832@waterleaf.sonytel.be>
References: <20040813145649.99935.qmail@web61309.mail.yahoo.com>
	 <Pine.GSO.4.58.0408131732510.28832@waterleaf.sonytel.be>
Content-Type: text/plain
Message-Id: <1092414230.14552.19.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Fri, 13 Aug 2004 17:23:51 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-13 at 17:34 +0200, Geert Uytterhoeven wrote:
> On Sat, 14 Aug 2004, [iso-8859-1] Zhan Rongkai wrote:
> > I am porting linux-2.6.4 to a new architecture
> 
> Which one?
> 
> > 'arch/$(ARCH)/boot/compressed/vmlinux.bin'
> 
> >  * linux/arch/frvnommu/boot/compressed/vmlinux.lds.in
>                 ^^^^^^^^
> IC, you forgot to obfuscate one occurrence :-)

Heh. frv isn't that new anyway. And the code he's working from seems to
be ancient since we merged the frv and frvnommu directories into
arch/frv/ when we did MMU support.

-- 
dwmw2

