Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268080AbUHXQ1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268080AbUHXQ1g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 12:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268084AbUHXQ1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 12:27:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:21121 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268080AbUHXQ1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 12:27:35 -0400
Date: Tue, 24 Aug 2004 09:25:33 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Laurent CARON <lcaron@apartia.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TG3(Tigoon) & Kernel 2.4.27
Message-Id: <20040824092533.65cb32da.rddunlap@osdl.org>
In-Reply-To: <412B5B35.7020701@apartia.fr>
References: <412B5B35.7020701@apartia.fr>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004 17:13:57 +0200 Laurent CARON wrote:

| Hello
| 
| When I try to compile kernel 2.4.27 for one of my servers i get this error.
| --------------
| drivers/net/net.o(.text+0x17550): In function `tg3_request_firmware': : 
| undefined reference to `request_firmware'
| drivers/net/net.o(.text+0x17652): In function `tg3_request_firmware': : 
| undefined reference to `release_firmware'
| -------------
| 
| Any clue?
| 
| PS: I can include a part of my .config

You need to enable CONFIG_EXPERIMENTAL and CONFIG_HOTPLUG
and then CONFIG_FW_LOADER in the Library routines menu.

--
~Randy
