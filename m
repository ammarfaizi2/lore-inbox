Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264336AbTEPBOV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 21:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264337AbTEPBOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 21:14:21 -0400
Received: from palrel12.hp.com ([156.153.255.237]:50334 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S264336AbTEPBOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 21:14:20 -0400
Date: Thu, 15 May 2003 18:27:07 -0700
To: Andrew Morton <akpm@digeo.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.5.69] rtnl-deadlock with usermodehelper and keventd
Message-ID: <20030516012707.GB20499@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <PAO-EX01Cv3uS7sBdxk00001183@pao-ex01.pao.digeo.com> <20030515.175348.45895365.davem@redhat.com> <20030515181211.5853fd18.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030515181211.5853fd18.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 06:12:11PM -0700, Andrew Morton wrote:
>
> Meanwhile please take a look at the leftover cleanups.  It fixes a bug in
> drivers/net/hamradio/dmascc.c too.
> 
> 
>  25-akpm/drivers/net/hamradio/dmascc.c  |    4 +---
>  25-akpm/drivers/net/irda/ali-ircc.c    |    7 ++-----
>  25-akpm/drivers/net/irda/donauboe.c    |    7 +------
>  25-akpm/drivers/net/irda/irda-usb.c    |   10 ++++------
>  25-akpm/drivers/net/irda/irport.c      |    7 ++-----
>  25-akpm/drivers/net/irda/irtty.c       |    7 ++-----
>  25-akpm/drivers/net/irda/nsc-ircc.c    |    7 ++-----
>  25-akpm/drivers/net/irda/sa1100_ir.c   |    7 ++-----
>  25-akpm/drivers/net/irda/toshoboe.c    |    8 ++------
>  25-akpm/drivers/net/irda/w83977af_ir.c |    7 ++-----
>  10 files changed, 20 insertions(+), 51 deletions(-)

	IrDA part of the patch applied and compiled fine here (I was
worried of header issues). And this doesn't conflict with the patches
I sent to Jeff ;-)
	I'll add that in my patch queue, just in case ;-)
	Thanks...

	Jean
