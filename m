Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269205AbUIHXdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269205AbUIHXdw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 19:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269220AbUIHXdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 19:33:52 -0400
Received: from the-village.bc.nu ([81.2.110.252]:6569 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269205AbUIHX32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 19:29:28 -0400
Subject: Re: ISA DMA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <413F7960.8070500@drzeus.cx>
References: <413F7960.8070500@drzeus.cx>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094682435.12335.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 08 Sep 2004 23:27:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-08 at 22:28, Pierre Ossman wrote:
> I'm trying to figure out how to do ISA DMA transfers. I can't figure out 
>   how to satisfy all the requirements the ISA DMA controller sets. I've 
> set a DMA mask of 0x00ffffff but mappings end up above the 16MB limit 
> nonetheless. And I have no idea how to keep transfers within the same 
> 64k boundary.

drivers/net/lance.c is a pretty good worked example of driving the old
ISA bus grunge. 


