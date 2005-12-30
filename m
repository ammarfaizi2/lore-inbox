Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbVL3CP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbVL3CP2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 21:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbVL3CP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 21:15:28 -0500
Received: from [139.30.44.16] ([139.30.44.16]:57 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1750821AbVL3CP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 21:15:27 -0500
Date: Fri, 30 Dec 2005 03:15:26 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Arjan van de Ven <arjan@infradead.org>
cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
In-Reply-To: <Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.63.0512300314180.20729@gockel.physik3.uni-rostock.de>
References: <1135798495.2935.29.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>  <20051228212313.GA4388@elte.hu>
 <20051228214845.GA7859@elte.hu>  <20051228201150.b6cfca14.akpm@osdl.org>
 <20051229073259.GA20177@elte.hu>  <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org>
  <20051229202852.GE12056@redhat.com>  <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org>
  <Pine.LNX.4.64.0512291322560.3298@g5.osdl.org>  <20051229224839.GA12247@elte.hu>
 <1135897092.2935.81.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Dec 2005, Tim Schmielau wrote:

>    > size vmlinux*
>       text    data     bss     dec     hex filename
>    2197105  386568  316840 2900513  2c4221 vmlinux
>    2144453  392100  316840 2853393  2b8a11 vmlinux.deinline

Doh! I forgot to set -Os.
Will better go to bed now and redo the numbers tomorrow.
