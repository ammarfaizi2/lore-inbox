Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbULURRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbULURRH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 12:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbULURRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 12:17:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:5013 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261809AbULURRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 12:17:05 -0500
Date: Tue, 21 Dec 2004 09:15:47 -0800
From: Greg KH <greg@kroah.com>
To: Arne Caspari <arne@datafloater.de>
Cc: Adrian Bunk <bunk@stusta.de>,
       Arne Caspari <arnem@informatik.uni-bremen.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ben Collins <bcollins@debian.org>,
       linux1394-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
Message-ID: <20041221171547.GD1459@kroah.com>
References: <20041220015320.GO21288@stusta.de> <41C694E0.8010609@informatik.uni-bremen.de> <20041220143901.GD457@phunnypharm.org> <1103555716.29968.27.camel@localhost.localdomain> <20041220154638.GE457@phunnypharm.org> <1103573716.31512.10.camel@localhost.localdomain> <41C7DFE9.5070604@informatik.uni-bremen.de> <20041221120012.GC5217@stusta.de> <41C81BF4.9070602@datafloater.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C81BF4.9070602@datafloater.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 01:49:56PM +0100, Arne Caspari wrote:
> 
> To make a long decision short:
> 
> There is no stable kernel API that an external developer can rely on?

That is correct.  Please see Documentation/stable_api_nonsense.txt for
details as to why this is so.

> And this is by intent: The only way for a vendor to write a driver for 
> Linux is to submit it to the kernel tree?

That's the best way.  See the above mentioned file for details as to why
it is a benifit for you to submit it to the tree.

thanks,

greg k-h
