Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269747AbTHSKPa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 06:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269900AbTHSKPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 06:15:30 -0400
Received: from trained-monkey.org ([209.217.122.11]:59913 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP id S269747AbTHSKP3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 06:15:29 -0400
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030818111522.A12835@devserv.devel.redhat.com>
	<m33cfzuen2.fsf@defiant.pm.waw.pl> <m3y8xqroqo.fsf@trained-monkey.org>
	<m3vfsuj7tj.fsf@defiant.pm.waw.pl>
From: Jes Sorensen <jes@wildopensource.com>
Date: 19 Aug 2003 06:15:30 -0400
In-Reply-To: <m3vfsuj7tj.fsf@defiant.pm.waw.pl>
Message-ID: <m3he4erm0t.fsf@trained-monkey.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Krzysztof" == Krzysztof Halasa <khc@pm.waw.pl> writes:

Krzysztof> Jes Sorensen <jes@wildopensource.com> writes:
>> Bzzzt, *wrong*! Take a look at
>> drivers/scsi/aic7xxx/aic7xxx_osm_pci.c, if you look at the code you
>> will notice that the hardware does support different masks for
>> consistent vs dynamic allocations (32 bit for consistent vs 39 or
>> 64 bit for dynamic).

Krzysztof> The hardware, maybe.

The hardware, yes.

Krzysztof> Will it be ok if I fix the consistent allocs to use
Krzysztof> consistent_dma_mask (some drivers will need a fix on i386
Krzysztof> etc.)?

That would be ideal I'd say.

Jes
