Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbVHJAuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbVHJAuG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 20:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbVHJAuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 20:50:06 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:57222 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1751019AbVHJAuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 20:50:05 -0400
Message-ID: <42F94F39.8060406@gmail.com>
Date: Wed, 10 Aug 2005 02:50:01 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] pci_find_device and pci_find_slot mark as deprecated
References: <42F72D4D.8030102@volny.cz> <200508082354.j78Ns1Cn028468@wscnet.wsc.cz> <20050809041133.GA10552@kroah.com> <4af2d03a0508090258942f536@mail.gmail.com> <20050809215737.GD22683@kroah.com> <42F94D54.5090802@gmail.com>
In-Reply-To: <42F94D54.5090802@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby napsal(a):

> *It removes most occurences of pci_find_device in the kernel tree.
> *pci_(get|find)_device(x, ANY_ID, ANY_ID, x) changes to 
> for_each_pci_dev(x).
>
> Generated in 2.6.13-rc5-mm1 kernel version. 

[...]

>  drivers/scsi/qlogicisp.c                     |    3 --

This maybe won't be needed, adrian bunk began removing process with that.
