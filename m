Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423315AbWJSLiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423315AbWJSLiQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 07:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423316AbWJSLiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 07:38:15 -0400
Received: from mail9.hitachi.co.jp ([133.145.228.44]:31416 "EHLO
	mail9.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1423315AbWJSLiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 07:38:14 -0400
Message-Type: Multiple Part
MIME-Version: 1.0
Message-ID: <XNM1$9$0$4$$3$3$7$A$9002708U4537639a@hitachi.com>
Content-Type: text/plain; charset="us-ascii"
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
From: <eiichiro.oiwa.nm@hitachi.com>
Cc: "David Miller" <davem@davemloft.net>, <alan@redhat.com>,
       <jesse.barnes@intel.com>, <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Date: Thu, 19 Oct 2006 20:38:09 +0900
References: <20061018.233102.74754142.davem@davemloft.net> 
    <XNM1$9$0$4$$3$3$7$A$9002705U45372f1d@hitachi.com> 
    <20061019.013732.30184567.davem@davemloft.net> 
    <XNM1$9$0$4$$3$3$7$A$9002706U45374cd7@hitachi.com> 
    <1161256834.17335.17.camel@localhost.localdomain>
Importance: normal
Subject: Re: pci_fixup_video change blows up on sparc64
X400-Content-Identifier: X4537639A00000M
X400-MTS-Identifier: [/C=JP/ADMD=HITNET/PRMD=HITACHI/;gmml160610192038028QX]
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It's impossible that multiple VGA cards, which have not the expansion
>> ROM, exist in a system regardless of multiple PCI domain system.
>
>Strange. I've worked on several machines where it could.
>
>The 0xC0000 is a physical address only as far as the bridge is concerned
>(if the bridge even implements it - not all do). The PCI bus or busses
>may not even be the root busses of the system. On such systems you can
>happily have multiple PCI root bridges each in their own address space
>and each with their own idea of where 0xC0000 maps if anywhere.

I am sorry. I mean, for example, if there are two PCI VGA cards and there
is the difference between VGA controllers, only one VGA BIOS at 0xC0000 can't
handle two PCI VGA cards.

My mention was bad. I'm sorry.


