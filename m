Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270780AbTGNTwe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 15:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270772AbTGNTux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 15:50:53 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:17166 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S270773AbTGNTui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:50:38 -0400
Date: Mon, 14 Jul 2003 22:04:52 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [KCONFIG] Optional choice values always get reset
In-Reply-To: <20030712073018.GA19038@gondor.apana.org.au>
Message-ID: <Pine.LNX.4.44.0307142149540.714-100000@serv>
References: <20030712073018.GA19038@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 12 Jul 2003, Herbert Xu wrote:

> As of 2.5.74, make oldconfig always disables existing optional choices
> even if they were selected previously.  For example, if all the EICON
> ISDN drivers were selected as modules, then make oldconfig will turn
> them off.
> 
> Part of the problem is that the choice value itself is computed before
> the SYMBOL_NEW flag is turned off.  This patch addresses that particular
> problem.

Thanks for the patch, I applied it with some small modifications, as there 
was a small problem left.

bye, Roman

