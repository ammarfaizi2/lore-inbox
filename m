Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275290AbRJARFb>; Mon, 1 Oct 2001 13:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275294AbRJARFV>; Mon, 1 Oct 2001 13:05:21 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:22181 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S275290AbRJARFT>; Mon, 1 Oct 2001 13:05:19 -0400
Date: Mon, 1 Oct 2001 13:05:47 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200110011705.f91H5lB31719@devserv.devel.redhat.com>
To: stephane@antefacto.com, linux-kernel@vger.kernel.org
Subject: Re: USB Issues on 2.4
In-Reply-To: <mailman.1001935801.16389.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1001935801.16389.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> First one (the intel) behaves fine, all modules loading up okay and all
> working smoothly.
> 
> Second one (via from hell) locks up the keyboard as soon as the usb-uhci
> is loaded up. This behavior happened on both 2.4.9 and 2.4.10 final
> kernels.

Are you saying that 2.4.8 worked? Please test that, it would
help narrowing the cause.

> I've been pointed to some bios issues with ABIT boards (got a KT7A-RAID)
> and especially IRQ sharing (got alot of PCI cards in the box).

Unlikely. In case of an IRQ storm whole box would lock,
not only its keyboard.

-- Pete
