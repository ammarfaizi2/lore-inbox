Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262735AbVA1Svb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbVA1Svb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 13:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbVA1SkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 13:40:12 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:37302 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262584AbVA1Sgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 13:36:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=e1BwqdrCpE31EOEiuKV+EEOh090jHM31quVJA8ixODwnnlUA04JlPkNta1jmryJj62n3pxvWGcrr1DwNZon6RlbrnW34FpZFtRCG+w/0ykLPLRXxEGHjxb8I0cdzyUAkis5vfnL5NJTy6WC73zqkmEQp/bSK4FWr17mP2vbSVPk=
Message-ID: <9e47339105012810362a0a7018@mail.gmail.com>
Date: Fri, 28 Jan 2005 13:36:48 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: Fwd: Patch to control VGA bus routing and active VGA device.
Cc: Jesse Barnes <jbarnes@sgi.com>, Greg KH <greg@kroah.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Matthew Wilcox <matthew@wil.cx>,
       linux-pci@atrey.karlin.mff.cuni.cz, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050128173222.GC30791@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339105011719436a9e5038@mail.gmail.com>
	 <20050125042459.GA32697@kroah.com>
	 <9e473391050127015970e1fedc@mail.gmail.com>
	 <200501270828.43879.jbarnes@sgi.com>
	 <20050128173222.GC30791@colo.lackof.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005 10:32:22 -0700, Grant Grundler
<grundler@parisc-linux.org> wrote:
> Moving the VGA device can only function within that legacy space
> the way the code is written now (using hard coded addresses).
> If it is intended to work with multiple IO Port address spaces,
> then it needs to use the pci_dev->resource[] and mangle that appropriately.

Post a patch an I will incorporate it. 

-- 
Jon Smirl
jonsmirl@gmail.com
