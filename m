Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbTLOLFQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 06:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTLOLFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 06:05:16 -0500
Received: from imag.imag.fr ([129.88.30.1]:6560 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S263475AbTLOLFI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 06:05:08 -0500
Date: Mon, 15 Dec 2003 11:56:52 +0100
Subject: Re: PCI lib for 2.4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linux-kernel@vger.kernel.org
To: Peter Chubb <peter@chubb.wattle.id.au>
From: =?ISO-8859-1?Q?Damien_Courouss=E9?= <damien.courousse@imag.fr>
In-Reply-To: <16348.59126.537876.178991@wombat.chubb.wattle.id.au>
Message-Id: <6414C79D-2EED-11D8-82D9-000393C76BFA@imag.fr>
Content-Transfer-Encoding: 8BIT
X-Mailer: Apple Mail (2.552)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Actually, it will be first a user-space driver.

Maybe I wasn't clear:

I link the PCI library with '-lpci' option, but it seems the library is 
not complete, ie I can't use the whole lib. For example, the compiler 
cannot link pci_resource_start() func. or pci_fond_device(). I think 
these are usually in all pci libraries... My lib does not support dma 
abilities too.

My problem is that I have several pci.h files which contain these 
function (the 'whole package?'), but I don't have the lib that fits 
to...

For example
 >>grep pci_resource_start /usr/lib/pcilib.a
returns nothing. I think it should.

I was just wondering how I will be able to retrieve the good lib, which 
I can't find on my PC.  Tried to update the Red Hat (and kernel), but 
it didn't change anything in my lib. I guess someone installed sthg on 
my PC, which removed the 'good' pci library, or changed it for an other 
lighter version.

Is there anything related with CONFIG_... flags??

Damien

Le dimanche, 14 déc 2003, à 23:40 Europe/Paris, Peter Chubb a écrit :

>>>>>> "Damien" == Damien Courouss <Damien> writes:
>
> Damien> Hi all, I'm a rookie in Linux development, and I have to
> Damien> develop a small driver for a data-acquisition card on PCI
> Damien> port.
>
> Is this a user=space or in-kernel driver?  A user-space driver will
> link with -lpci; an in-kernel driver needs to be built as if part
> of the kernel.
>
> --
> Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT 
> gelato.unsw.edu.au
> The technical we do immediately,  the political takes *forever*
>
  
  
