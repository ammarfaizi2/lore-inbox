Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267686AbSLTCHo>; Thu, 19 Dec 2002 21:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267687AbSLTCHo>; Thu, 19 Dec 2002 21:07:44 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:24300
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267686AbSLTCHn>; Thu, 19 Dec 2002 21:07:43 -0500
Subject: Re: PATCH 2.5.x disable BAR when sizing
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Grant Grundler <grundler@cup.hp.com>
Cc: mj@ucw.cz, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       turukawa@icc.melco.co.jp
In-Reply-To: <20021219213712.0518B12CB2@debian.cup.hp.com>
References: <20021219213712.0518B12CB2@debian.cup.hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Dec 2002 02:54:28 +0000
Message-Id: <1040352868.30778.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-19 at 21:37, Grant Grundler wrote:
> 
> Martin,
> In April 2002, turukawa@icc.melco.co.jp sent a 2.4.x patch to disable
> BARs while the BARs were being sized.  I've "forward ported" this patch
> to 2.5.x (appended).  turukawa's excellent problem description and
> original posting are here:
> 	https://lists.linuxia64.org/archives//linux-ia64/2002-April/003302.html
> 
> David Mosberger agrees this is an "obvious fix".
> We've been using this in the ia64 2.4 code stream since about August.

We've rejected this twice already from different people.

Nothing says your memory can't be behind the bridge and you just turned
memory access off. Whoops bang, game over.

And yes this happens on some PC class systems.

Alan

