Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbVISDHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbVISDHd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 23:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVISDHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 23:07:33 -0400
Received: from silver.veritas.com ([143.127.12.111]:61020 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932303AbVISDHd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 23:07:33 -0400
Date: Mon, 19 Sep 2005 04:07:04 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Daniel Ritz <daniel.ritz@gmx.ch>
cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm2
In-Reply-To: <200509182349.17632.daniel.ritz@gmx.ch>
Message-ID: <Pine.LNX.4.61.0509190402500.16591@goblin.wat.veritas.com>
References: <20050908053042.6e05882f.akpm@osdl.org> <200509121206.05450.rjw@sisk.pl>
 <200509121209.47736.rjw@sisk.pl> <200509182349.17632.daniel.ritz@gmx.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 19 Sep 2005 03:07:32.0871 (UTC) FILETIME=[472F1970:01C5BCC7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Sep 2005, Daniel Ritz wrote:
> 
> interesting. i'd say we get interrupt storms from usb which then hurt when
> yenta has it's handler installed but usb has not. usb/hcd-pci.c frees the
> irq on suspend...so it may be enough not to do that (survives suspend-to-ram
> and suspend-to-disk here. yes, restore too :)

Will make no difference to my case: I have no USB,
so don't even build drivers/usb/core/hcd-pci.o.

Hugh
