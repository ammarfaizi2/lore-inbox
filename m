Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751526AbWDBXIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbWDBXIN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 19:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbWDBXIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 19:08:13 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42883 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751523AbWDBXIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 19:08:11 -0400
Subject: Re: Who wants to test cracklinux??
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ben Ford <ben@kalifornia.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1144017581.3066.34.camel@testmachine>
References: <20060328221223.80753cab.letterdrop@gmx.de>
	 <20060328224929.GC5760@elf.ucw.cz>  <44305193.5080408@kalifornia.com>
	 <1144017581.3066.34.camel@testmachine>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Apr 2006 00:16:11 +0100
Message-Id: <1144019771.31123.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-04-03 at 00:39 +0200, Arjan van de Ven wrote:
> is there any difference? I mean... if you can outb you for all intents
> and purposes are root anyway ;) (like you can overwrite any memory in
> the system etc etc)

There are two clear uses

#1	Its possible to write such a module to allow only some ports to be
accessed, eg to export a PCI device for learning purposes

#2	As root you can make mistakes and mess up a box. Having the ability
to do stuff and having the default as "its allowed" differ. Giving
someone iopl rights is a bit like giving someone sudo. The security
against active attack is unchanged, the security against screwups is
higher


Alan

