Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317931AbSIJSe6>; Tue, 10 Sep 2002 14:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317945AbSIJSe6>; Tue, 10 Sep 2002 14:34:58 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:4851 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317931AbSIJSe5>; Tue, 10 Sep 2002 14:34:57 -0400
Subject: Re: ignore pci devices?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Martin Mares <mj@ucw.cz>
Cc: Gerd Knorr <kraxel@bytesex.org>,
       Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020910163023.GA3862@ucw.cz>
References: <20020910134708.GA7836@bytesex.org> 
	<20020910163023.GA3862@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 10 Sep 2002 19:42:42 +0100
Message-Id: <1031683362.1537.104.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-10 at 17:30, Martin Mares wrote:
> > Is there already something generic for this?  Some kernel parameter
> > which makes pci_module_init() skip a given PCI device for example?
> 
> What about writing a "driver" which will just bind to a given
> PCI device, so that the other drivers will see it's already handled?

pci_driver has no implicit ordering.

