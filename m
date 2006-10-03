Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbWJCK6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbWJCK6o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 06:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWJCK6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 06:58:44 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48875 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030296AbWJCK6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 06:58:43 -0400
Subject: Re: Undefined '.bus_to_virt', '.virt_to_bus' causes compile error
	on Powerpc 64-bit
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Judith Lebzelter <judith@osdl.org>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
In-Reply-To: <1159837539.5482.15.camel@localhost.localdomain>
References: <20061002214954.GD665@shell0.pdx.osdl.net>
	 <1159837539.5482.15.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 03 Oct 2006 12:23:16 +0100
Message-Id: <1159874596.17553.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-10-03 am 11:05 +1000, ysgrifennodd Benjamin Herrenschmidt:
> On Mon, 2006-10-02 at 14:49 -0700, Judith Lebzelter wrote:
> > Hello:
> > 
> > For the automated cross-compile builds at OSDL, powerpc 64-bit 
> > 'allmodconfig' is failing.  The warnings/errors below appear in 
> > the 'modpost' stage of kernel compiles for 2.6.18 and -mm2 kernels.
> 
> All those drivers are bogus and need to be updated. They should be
> marked CONFIG_BROKEN

Several of them are only really meaningful on PC so marking them BROKEN
is the wrong answer. Some of them definitely do need updating but stuff
like the remaining OSS drivers are just waiting to die out quietly.

