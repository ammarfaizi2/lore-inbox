Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270964AbSISKVB>; Thu, 19 Sep 2002 06:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271004AbSISKVB>; Thu, 19 Sep 2002 06:21:01 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:22515
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S270964AbSISKVA>; Thu, 19 Sep 2002 06:21:00 -0400
Subject: Re: Compile problem w/ 2.4.20-pre7-ac2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Wes Kurdziolek <wkurdzio@cs.vt.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20020919080500.GB936@suse.de>
References: <1032409341.6480.2.camel@yavin>  <20020919080500.GB936@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Sep 2002 11:30:23 +0100
Message-Id: <1032431423.26669.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-19 at 09:05, Jens Axboe wrote:

> -static ide_pci_device_t piix_pci_info[] __devinit = {
> +static ide_pci_device_t piix_pci_info[] __initdata = {

That won't work either. The table is needed in cases __devinit is - its
basically __devinitdata. I need to go look up the right types for it

