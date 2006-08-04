Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWHDKtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWHDKtw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 06:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161149AbWHDKtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 06:49:51 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36253 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751251AbWHDKtv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 06:49:51 -0400
Subject: Re: [PATCH]console utf-8 mode fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adam =?UTF-8?Q?Tla=C5=82ka?= <atlka@pg.gda.pl>, akpm@osdl.org
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <44D31E31.70009@pg.gda.pl>
References: <44D31E31.70009@pg.gda.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Fri, 04 Aug 2006 12:08:25 +0100
Message-Id: <1154689705.23655.211.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-04 am 12:15 +0200, ysgrifennodd Adam Tlałka:
> Description: patch for drivers/char/vt.c
> 
> Fixed utf-8 mode so alternate charset modes always work according
> to control sequences interpreted in do_con_trol function
> preserving backward US-ASCII and VT100 semigraphics compatibility.
> 
> Malformed utf-8 sequences are represented as sequences of replacement 
> glyphs,original codes or '?' as a last resort.
> 
> unicode-xterm, gnome-terminal, kconsole and other terminal emulators
> in utf-8 mode respect acsc, enacs, rmacs sequences. Also I found that 
> some important system programs (from Debian distro) uses acsc in utf-8 
> mode - dselect, aptitude, w3m for example.
> 
> Signed-off-by: Adam Tla/lka <atlka@pg.gda.pl>

Testing this in -mm would be good.

Acked-by: Alan Cox <alan@redhat.com>
