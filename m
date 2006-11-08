Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754612AbWKHVyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754612AbWKHVyu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 16:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754619AbWKHVyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 16:54:50 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7595 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1754612AbWKHVyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 16:54:49 -0500
Subject: Re: IDE cs5530 hda: lost interrupt
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Saulo <slima@tse.gov.br>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45525EB0.1070907@tse.gov.br>
References: <455254B8.4000704@tse.gov.br>
	 <1163022263.23956.100.camel@localhost.localdomain>
	 <45525EB0.1070907@tse.gov.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Nov 2006 21:59:33 +0000
Message-Id: <1163023173.23956.111.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-11-08 am 19:48 -0300, ysgrifennodd Saulo:
> I tried others operating systems, this machine work fine with DOS 6.22
> and Windows CE 4.2, but lock on FreeBSD and Linux.

So it works with systems that don't use the interrupt ? Is this some
kind of PDA type device designed for Windows CE where they've not
bothered wiring the interrupt perhaps.

If so you'll need to write a polling CF driver for it, which actually is
one of those things that we could do with for some other embedded cases
too.

Alan

