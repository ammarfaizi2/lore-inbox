Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266011AbTFWNKZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 09:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbTFWNKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 09:10:25 -0400
Received: from zork.zork.net ([64.81.246.102]:25536 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S266011AbTFWMvE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 08:51:04 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.73 : undefined reference to pci_destroy_dev
References: <3EF6F942.7090506@wanadoo.fr>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Mon, 23 Jun 2003 14:05:10 +0100
In-Reply-To: <3EF6F942.7090506@wanadoo.fr> =?iso-8859-1?q?(R=E9mi?= COLINET's message of "Mon, 23 Jun 2003 14:57:38 +0200")
Message-ID: <6u7k7dndvd.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rémi COLINET <remi.colinet@wanadoo.fr> writes:

> Making bzImage with 2.5.73, I'm getting the following undefined reference.
> I have to set the PCI hotplug in my .config file in order to get the
> bzImage.
>
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `pci_remove_bus_device':
> drivers/built-in.o(.text+0x367b): undefined reference to `pci_destroy_dev'
> make: *** [.tmp_vmlinux1] Error 1

Grek KH posted a patch for this.

http://groups.google.com/groups?selm=1pJ0.2Kr.7%40gated-at.bofh.it&oe=UTF-8&output=gplain

