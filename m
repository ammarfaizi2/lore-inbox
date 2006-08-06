Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWHFXNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWHFXNR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 19:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWHFXNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 19:13:17 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:10450 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750759AbWHFXNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 19:13:16 -0400
Subject: Re: [PATCH] [MMC] Fix base address configuration in wbsd
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Ben Dooks <ben@fluff.org>, linux-kernel@vger.kernel.org
In-Reply-To: <44D66491.1090606@drzeus.cx>
References: <20060806202223.13663.66134.stgit@poseidon.drzeus.cx>
	 <20060806204842.GE16816@flint.arm.linux.org.uk>
	 <44D657BF.6070004@drzeus.cx>
	 <20060806210509.GF16816@flint.arm.linux.org.uk>
	 <44D65F4D.3060907@drzeus.cx> <20060806213524.GC8907@home.fluff.org>
	 <44D66491.1090606@drzeus.cx>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 07 Aug 2006 00:32:21 +0100
Message-Id: <1154907141.25998.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-08-06 am 23:52 +0200, ysgrifennodd Pierre Ossman:
> Sorry, my intention wasn't to assert that it was only to be used on x86
> but that the 16-bit assumption was safe.

Your ISA bus mappings on a non x86 processor are likely to be 32bit MMIO
-> PIO windows in memory space. 

Alan

