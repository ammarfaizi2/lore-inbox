Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263305AbUJ2Mgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263305AbUJ2Mgl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 08:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263307AbUJ2Mgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 08:36:40 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:14503 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263305AbUJ2MgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 08:36:08 -0400
Subject: Re: [RFC] Linux 2.6.9.1-pre1 contents
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <200410282205_MC3-1-8D77-F5C5@compuserve.com>
References: <200410282205_MC3-1-8D77-F5C5@compuserve.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1099049557.13082.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 29 Oct 2004 12:33:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-10-29 at 03:02, Chuck Ebbert wrote:
> 3c59x_pci_disable_device.patch
>         Add missing pci_disable_device() in failure paths
>         NOTE: 3c59x_remove_one() needs disable call, too
>               ...as do tulip, natsemi, etc.

The mm tree with this in has shown some problems which aren't yet
fully explained and are more likely the eeprom thing.

>         Fixes from 2.6.9-ac4

I'll post -ac5 shortly although you seem to have most of that
and a lot more.

> ide_maxtor_probe.patch
>         Another Maxtor IDE drive serial number oddity

This is definitely wrong, the others look fairly sane although there are
a lot that are for such obscure cases they seem to add not reduce risk.

Alan

