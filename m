Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262573AbVAETZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbVAETZG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 14:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbVAETXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 14:23:54 -0500
Received: from main.gmane.org ([80.91.229.2]:57790 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262568AbVAETW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 14:22:56 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andrey Melnikoff <temnota+news@kmv.ru>
Subject: Re: Questions about the CMD640 and RZ1000 bugfix support options
Date: Wed, 5 Jan 2005 21:58:54 +0300
Message-ID: <e0qta2-7jr.ln1@kenga.kmv.ru>
References: <41D5D206.1040107@mathematica.scientia.net> <1104676209.15004.58.camel@localhost.localdomain>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: kenga.kmv.ru
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.6-rc1 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2004-12-31 at 22:26, Christoph Anton Mitterer wrote:
> > Hi.
> > 
> > First of all: A happy new year in advance!
> > 
> > Now to my question:
> > In the kernel-configuration there are the two options:
> > CONFIG_BLK_DEV_CMD640        CMD640 chipset bugfix/support
> > and
> > CONFIG_BLK_DEV_RZ1000        RZ1000 chipset bugfix/support
> > 
> > At least the second of those two seems to cause some little slowdown 
> > ("This may slow disk throughput by a few percent, but at least things 
> They only trigger for the affected chipsets
But enabled by default. Maybe disable it by default ? Or make depend with 
CONFIG_M586 || CONFIG_M586TSC || CONFIG_M586MMX ?

