Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318488AbSHURI2>; Wed, 21 Aug 2002 13:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318500AbSHURI2>; Wed, 21 Aug 2002 13:08:28 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:46063 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318488AbSHURI1>; Wed, 21 Aug 2002 13:08:27 -0400
Subject: Re: PCI device reset
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020821190744.14cb4f45.gigerstyle@gmx.ch>
References: <20020821190744.14cb4f45.gigerstyle@gmx.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Aug 2002 18:13:38 +0100
Message-Id: <1029950018.26533.100.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-21 at 18:07, Marc Giger wrote:
> Is it possible to reset a pci device on runtime like that the device has the feeling, it is a restart of the computer?
> 
> Does anybody know what I mean?:-)
> 
> My cardbus bridge needs a hard reset after a suspend..:-(

Which cardbus bridge do you have. Also dump the pci status before and
after. Its most likely the actual problem is something like the BIOS
suspend not saving the pci configuration space

