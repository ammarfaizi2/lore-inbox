Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269215AbUIHX3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269215AbUIHX3N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 19:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269216AbUIHX2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 19:28:15 -0400
Received: from the-village.bc.nu ([81.2.110.252]:5289 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269220AbUIHX0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 19:26:54 -0400
Subject: Re: irq 26: nobody cared!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adam K Kirchhoff <adamk@voicenet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409081726530.1820@thorn.ashke.com>
References: <Pine.LNX.4.58.0409081726530.1820@thorn.ashke.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094682284.12336.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 08 Sep 2004 23:24:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-08 at 22:35, Adam K Kirchhoff wrote:
> I have a dual P3 system (via motherboard) with 1.5 gigs of RAM (with
> highmem enabled in the kernel).  Under heavy networking load, I get the
> following error:

Try variously turning off acpi and the apic. If the routing tables are
still shot try the irqfixup patch I posted, it might well rescue your
box.


