Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268179AbUHXSen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268179AbUHXSen (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 14:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268180AbUHXSem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 14:34:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1712 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268179AbUHXSec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 14:34:32 -0400
Date: Tue, 24 Aug 2004 11:34:07 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lcaron@apartia.fr, linux-kernel@vger.kernel.org
Subject: Re: TG3(Tigoon) & Kernel 2.4.27
Message-Id: <20040824113407.287f0408.davem@redhat.com>
In-Reply-To: <20040824092533.65cb32da.rddunlap@osdl.org>
References: <412B5B35.7020701@apartia.fr>
	<20040824092533.65cb32da.rddunlap@osdl.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004 09:25:33 -0700
"Randy.Dunlap" <rddunlap@osdl.org> wrote:

> | --------------
> | drivers/net/net.o(.text+0x17550): In function `tg3_request_firmware': : 
> | undefined reference to `request_firmware'
> | drivers/net/net.o(.text+0x17652): In function `tg3_request_firmware': : 
> | undefined reference to `release_firmware'
> | -------------
> | 
> | Any clue?
> | 
> | PS: I can include a part of my .config
> 
> You need to enable CONFIG_EXPERIMENTAL and CONFIG_HOTPLUG
> and then CONFIG_FW_LOADER in the Library routines menu.

Oh on the contrary, I've never seen a call to request_firmware()
in any copy of the tg3 driver and that's strange being that I'm
the maintainer. :-)

People, if you're going to use patched up kernels, report your
problems to the people you got the kernel from.  Thanks.
