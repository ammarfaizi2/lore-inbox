Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288757AbSAQOIb>; Thu, 17 Jan 2002 09:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288748AbSAQOIW>; Thu, 17 Jan 2002 09:08:22 -0500
Received: from trained-monkey.org ([209.217.122.11]:25101 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id <S288767AbSAQOHl>; Thu, 17 Jan 2002 09:07:41 -0500
From: Jes Sorensen <jes@trained-monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15430.55969.201939.609401@trained-monkey.org>
Date: Thu, 17 Jan 2002 09:07:29 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        marcelo@conectiva.com.br (Marcelo Tosatti)
Subject: Re: [patch] VAIO irq assignment fix
In-Reply-To: <E16RDMy-0003W6-00@the-village.bc.nu>
In-Reply-To: <15430.55835.417188.484427@trained-monkey.org>
	<E16RDMy-0003W6-00@the-village.bc.nu>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

Alan> Surely pci_enable_device should do that anyway?
>>  The problem is that the interrupt is not set in the PIRQ table so if
>> we don't shoehorn it in, the interrupt source wont be found.

Alan> What happens if you use the current ACPI patch btw ?

Nothing ;(

The option that says 'use ACPI for interrupt routing' doesn't do
anything yet.

Jes
