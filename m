Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbTK1Tli (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 14:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbTK1Tli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 14:41:38 -0500
Received: from [217.73.129.129] ([217.73.129.129]:35458 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S263376AbTK1Tkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 14:40:45 -0500
Date: Fri, 28 Nov 2003 21:40:31 +0200
Message-Id: <200311281940.hASJeVSD008668@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: Current 2.4.23-rc* kernels has broken ACPI (at least for me).
To: ender@debian.org, linux-kernel@vger.kernel.org
References: <200311281615.00715.ender@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

David Mart?nez Moreno <ender@debian.org> wrote:
DMnM> PCI: PCI BIOS revision 2.10 entry at 0xfd9ce, last bus=1
DMnM> PCI: Using configuration type 1
DMnM> Unable to handle kernel NULL pointer dereference at virtual address 000000ae

This very same oops was cured for me by
cp .config .. ; make distclean ; mv ../.config . ; make oldconfig ;
make bzImage modules

Bye,
    Oleg
