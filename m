Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265944AbUFIT6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265944AbUFIT6M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 15:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265945AbUFIT6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 15:58:12 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:62218 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265944AbUFIT6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 15:58:11 -0400
Subject: RE: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Robert White <rwhite@casabyte.com>, "'Ingo Molnar'" <mingo@elte.hu>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'Mike McCormack'" <mike@codeweavers.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.56.0406091911340.26677@jjulnx.backbone.dif.dk>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAWUyJbbFwtUuY/ZGbgGI8TwEAAAAA@casabyte.com>
	 <Pine.LNX.4.56.0406091911340.26677@jjulnx.backbone.dif.dk>
Content-Type: text/plain
Date: Wed, 09 Jun 2004 21:58:15 +0200
Message-Id: <1086811095.1982.5.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-09 at 19:14 +0200, Jesper Juhl wrote:

> Just having the abillity to turn protection off opens the door. If it is
> possible to turn it off then a way will be found to do it - either via
> buggy kernel code or otherwhise. Only safe approach is to have it
> enabled by default and not be able to turn it off IMHO.

Much like LIDS works... You can configure, at build time, the kernel so
you can't switch the LIDS protection at all. Moreover, in case you want
to allow switching LIDS on/off, you can restrict such change to a
program that is running, at most, at the console, or over a serial line.

IMHO, I think that by definition, and programatically, allowing NX/
ExecShield to be turned on and off is an exploitable way of cracking a
system. I'd better like the LIDS approach.

