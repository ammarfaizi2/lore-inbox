Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVECEQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVECEQj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 00:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVECEQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 00:16:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:61386 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261374AbVECEQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 00:16:31 -0400
Date: Mon, 2 May 2005 21:18:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matt Mackall <mpm@selenic.com>
cc: Bill Davidsen <davidsen@tmr.com>, Morten Welinder <mwelinder@gmail.com>,
       Sean <seanlkml@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
In-Reply-To: <20050503032916.GE22038@waste.org>
Message-ID: <Pine.LNX.4.58.0505022116080.3594@ppc970.osdl.org>
References: <20050429165232.GV21897@waste.org> <427650E7.2000802@tmr.com>
 <Pine.LNX.4.58.0505021457060.3594@ppc970.osdl.org> <20050502223002.GP21897@waste.org>
 <Pine.LNX.4.58.0505021540070.3594@ppc970.osdl.org> <20050503000011.GA22038@waste.org>
 <Pine.LNX.4.58.0505021932270.3594@ppc970.osdl.org> <20050503032916.GE22038@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 May 2005, Matt Mackall wrote:
> 
> The delta is not the object I care about and its representation is
> arbitrary. In fact different branches will store different deltas
> depending on how their DAGs get topologically sorted. The object I
> care about is the original text, so that's the hash I store.

Ok. In that case, it sounds like you're really doing everything git is
doing, except your "blob" objects effectively can have pointers to a
previous object (and you have a different on-disk representation)?  Is
that correct?

			Linus
