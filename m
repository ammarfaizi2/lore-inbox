Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268155AbUI2CaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268155AbUI2CaR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 22:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268163AbUI2C2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 22:28:32 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:41865 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268155AbUI2C1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 22:27:25 -0400
Subject: Re: [PATCH] Use msleep_interruptible for therm_adt7467.c kernel
	thread
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: akpm@osdl.org, benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mdz@canonical.com, janitor@sternwelten.at
In-Reply-To: <20040929015827.GA26337@gondor.apana.org.au>
References: <20040927102552.GA19183@gondor.apana.org.au>
	 <1096289501.9930.19.camel@localhost.localdomain>
	 <20040929015827.GA26337@gondor.apana.org.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096421071.14637.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 29 Sep 2004 02:24:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-29 at 02:58, Herbert Xu wrote:
> > A more interesting question is why this isn't being driven off a
> > timer ?
> 
> It probably could if the stuff afterwards doesn't sleep.

schedule_work() ?

